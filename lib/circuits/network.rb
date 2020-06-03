# frozen_string_literal: true

require('circuits/current_source')
require('circuits/ground')
require('circuits/inductor')
require('circuits/resistor')
require('circuits/voltage_source')
require('matrix')

module Circuits
  class Network
    attr_reader :nodes
    attr_reader :components

    def initialize(nodes, components)
      @nodes = nodes
      @components = components
    end

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
        node_indices = component.nodes.map(&nodes.method(:index))
        case component
        when Ground
          conductances[node_indices[0], node_indices[0]] += Float::INFINITY
        when Resistor
          conductances[node_indices[0], node_indices[0]] += component.conductance
          conductances[node_indices[1], node_indices[1]] += component.conductance
          conductances[node_indices[0], node_indices[1]] -= component.conductance
          conductances[node_indices[1], node_indices[0]] -= component.conductance
        when Inductor, VoltageSource
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
        node_indices = voltage_source.nodes.map(&nodes.method(:index))
        case voltage_source
        when CurrentSource
          currents[node_indices[0], 0] += value
          currents[node_indices[1], 0] -= value
        when Inductor
          currents[index, 0] = 0
        when VoltageSource
          currents[index, 0] = voltage_source.voltage
        end
      end

      currents
    end

    def voltages
      conductances.inverse * currents
    end
  end
end
