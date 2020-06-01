# frozen_string_literal: true

require('matrix')

Node =
  Struct.new(:id, :components) do
    def initialize(id, components)
      super
      components.each do |component, index|
        component.nodes[index] = self
      end
    end
  end

Component =
  Struct.new(:id, :nodes) do
    def initialize(id, nodes)
      super
      nodes.each do |index, node|
        node.components[self] = index
      end
    end
  end

class Ground < Component
  def voltage_source?
    false
  end
end

class Resistor < Component
  attr_reader :resistance

  def initialize(id, nodes, resistance)
    super(id, nodes)
    @resistance = Float(resistance)
  end

  def conductance
    1 / resistance
  end

  def voltage_source?
    false
  end
end

class VoltageSource < Component
  attr_reader :voltage

  def initialize(id, nodes, voltage)
    super(id, nodes)
    @voltage = Float(voltage)
  end

  def voltage_source?
    true
  end
end

Network =
  Struct.new(:nodes, :components) do
    def offset
      nodes.count
    end

    def size
      offset + components.count(&:voltage_source?)
    end

    def voltage_sources
      components.select(&:voltage_source?)
    end

    def conductances
      conductances = Matrix.zero(size)

      components.each do |component|
        case component
        when Ground
          node0_index = nodes.index(component.nodes[0])
          conductances[node0_index, node0_index] += Float::INFINITY
        when Resistor
          node0_index = nodes.index(component.nodes[0])
          node1_index = nodes.index(component.nodes[1])
          conductances[node0_index, node0_index] += component.conductance
          conductances[node1_index, node1_index] += component.conductance
          conductances[node0_index, node1_index] -= component.conductance
          conductances[node1_index, node0_index] -= component.conductance
        when VoltageSource
          node0_index = nodes.index(component.nodes[0])
          node1_index = nodes.index(component.nodes[1])
          voltage_source_index = offset + voltage_sources.index(component)
          conductances[node0_index, voltage_source_index] -= 1
          conductances[voltage_source_index, node0_index] -= 1
          conductances[node1_index, voltage_source_index] += 1
          conductances[voltage_source_index, node1_index] += 1
        end
      end

      conductances
    end

    def currents
      currents = Matrix.zero(size, 1)

      voltage_sources.each.with_index(offset) do |voltage_source, index|
        currents[index, 0] = voltage_source.voltage
      end

      currents
    end

    def voltages
      conductances.inverse * currents
    end
  end
