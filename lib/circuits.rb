require('matrix')

Node = Struct.new(:id)

Component = Struct.new(:id, :node_0, :node_1)

class Resistor < Component
  attr_reader :resistance

  def initialize(id, node_0, node_1, resistance)
    super(id, node_0, node_1)
    @resistance = resistance.to_f
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

  def initialize(id, node_0, node_1, voltage)
    super(id, node_0, node_1)
    @voltage = voltage.to_f
  end

  def voltage_source?
    true
  end
end

Network = Struct.new(:nodes, :components) do
  def offset
    nodes.count - 1
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
      node_0_index = nodes.index(component.node_0) - 1
      node_1_index = nodes.index(component.node_1) - 1
      case component
      when Resistor
        if node_0_index != -1
          conductances[node_0_index, node_0_index] -= component.conductance
        end
        if node_1_index != -1
          conductances[node_1_index, node_1_index] -= component.conductance
        end
        if node_0_index != -1 && node_1_index != -1
          conductances[node_0_index, node_1_index] += component.conductance
          conductances[node_1_index, node_0_index] += component.conductance
        end
      when VoltageSource
        voltage_source_index = offset + voltage_sources.index(component)
        if node_0_index != -1
          conductances[node_0_index, voltage_source_index] -= 1
          conductances[voltage_source_index, node_0_index] -= 1
        end
        if node_1_index != -1
          conductances[node_1_index, voltage_source_index] += 1
          conductances[voltage_source_index, node_1_index] += 1
        end
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

NODES = %w[V0 V1 V2 V3].map(&Node.method(:new))

NETWORK = Network.new(NODES, [
  VoltageSource.new('VA', NODES[0], NODES[1], 1),
  Resistor.new('R1', NODES[1], NODES[2], 1000),
  Resistor.new('R2', NODES[2], NODES[3], 1000),
  Resistor.new('R3', NODES[3], NODES[0], 1000)
])
