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

class Ground < Resistor
  def initialize(id, nodes)
    super(id, nodes, 0)
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
        node_indices = component.nodes.values.map(&nodes.method(:index))
        case component
        when Ground
          conductances[node_indices[0], node_indices[0]] += Float::INFINITY
        when Resistor
          conductances[node_indices[0], node_indices[0]] += component.conductance
          conductances[node_indices[1], node_indices[1]] += component.conductance
          conductances[node_indices[0], node_indices[1]] -= component.conductance
          conductances[node_indices[1], node_indices[0]] -= component.conductance
        when VoltageSource
          voltage_source_index = offset + voltage_sources.index(component)
          conductances[node_indices[0], voltage_source_index] -= 1
          conductances[voltage_source_index, node_indices[0]] -= 1
          conductances[node_indices[1], voltage_source_index] += 1
          conductances[voltage_source_index, node_indices[1]] += 1
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
