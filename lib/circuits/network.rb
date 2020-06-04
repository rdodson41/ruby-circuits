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

    def node_indices
      @node_indices ||= components.flat_map(&:nodes).uniq.each_with_index.to_h
    end

    def offset
      node_indices.count
    end

    def size
      offset + components.count(&:voltage_source?)
    end

    def voltage_sources
      components.select(&:voltage_source?)
    end

    def modified_nodal_analysis
      conductances = Matrix.zero(size)
      currents = Matrix.zero(size, 1)

      components.each do |component|
        component_node_indices = component.nodes.map { |node| node_indices[node] }
        case component
        when Ground
          conductances[component_node_indices[0], component_node_indices[0]] += component.conductance
        when Resistor
          conductances[component_node_indices[0], component_node_indices[0]] += component.conductance
          conductances[component_node_indices[1], component_node_indices[1]] += component.conductance
          conductances[component_node_indices[0], component_node_indices[1]] -= component.conductance
          conductances[component_node_indices[1], component_node_indices[0]] -= component.conductance
        when CurrentSource
          currents[component_node_indices[0], 0] += component.current
          currents[component_node_indices[1], 0] -= component.current
        when Inductor
          voltage_source_index = offset + voltage_sources.index(component)
          conductances[component_node_indices[0], voltage_source_index] -= 1
          conductances[voltage_source_index, component_node_indices[0]] -= 1
          conductances[component_node_indices[1], voltage_source_index] += 1
          conductances[voltage_source_index, component_node_indices[1]] += 1
          currents[voltage_source_index, 0] = 0
        when VoltageSource
          voltage_source_index = offset + voltage_sources.index(component)
          conductances[component_node_indices[0], voltage_source_index] -= 1
          conductances[voltage_source_index, component_node_indices[0]] -= 1
          conductances[component_node_indices[1], voltage_source_index] += 1
          conductances[voltage_source_index, component_node_indices[1]] += 1
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
