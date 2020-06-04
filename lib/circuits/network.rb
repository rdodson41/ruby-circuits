# frozen_string_literal: true

require('circuits/capacitor')
require('circuits/current_source')
require('circuits/ground')
require('circuits/inductor')
require('circuits/resistor')
require('circuits/voltage_source')
require('matrix')

module Circuits
  class Network
    attr_reader :components

    def initialize(components)
      @components = components
    end

    def nodes
      @nodes ||= components.flat_map(&:nodes).uniq
    end

    def offset
      @offset ||= nodes.count
    end

    def size
      @size ||= offset + components.count(&:voltage_source?)
    end

    def node_indices
      @node_indices ||= nodes.each.with_index.to_h
    end

    def modified_nodal_analysis
      conductances = Matrix.zero(size)
      currents = Matrix.zero(size, 1)

      components.reject(&:voltage_source?).each do |component|
        case component
        when Ground
          conductances[node_indices[component.nodes[0]], node_indices[component.nodes[0]]] += component.conductance
        when Resistor
          conductances[node_indices[component.nodes[0]], node_indices[component.nodes[0]]] += component.conductance
          conductances[node_indices[component.nodes[1]], node_indices[component.nodes[1]]] += component.conductance
          conductances[node_indices[component.nodes[0]], node_indices[component.nodes[1]]] -= component.conductance
          conductances[node_indices[component.nodes[1]], node_indices[component.nodes[0]]] -= component.conductance
        when CurrentSource
          currents[node_indices[component.nodes[0]], 0] += component.current
          currents[node_indices[component.nodes[1]], 0] -= component.current
        end
      end

      components.select(&:voltage_source?).each.with_index(offset) do |component, voltage_source_index|
        case component
        when Inductor
          conductances[node_indices[component.nodes[0]], voltage_source_index] -= 1
          conductances[voltage_source_index, node_indices[component.nodes[0]]] -= 1
          conductances[node_indices[component.nodes[1]], voltage_source_index] += 1
          conductances[voltage_source_index, node_indices[component.nodes[1]]] += 1
          currents[voltage_source_index, 0] = 0
        when VoltageSource
          conductances[node_indices[component.nodes[0]], voltage_source_index] -= 1
          conductances[voltage_source_index, node_indices[component.nodes[0]]] -= 1
          conductances[node_indices[component.nodes[1]], voltage_source_index] += 1
          conductances[voltage_source_index, node_indices[component.nodes[1]]] += 1
          currents[voltage_source_index, 0] = component.voltage
        end
      end

      [conductances, currents]
    end

    def voltages
      conductances, currents = modified_nodal_analysis
      conductances.inverse * currents
    end
  end
end
