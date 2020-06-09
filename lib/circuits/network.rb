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

      components.select(&:conductor?).each do |component|
        component.nodes.each do |node|
          conductances[node_indices[node], node_indices[node]] += component.conductance
        end
        component.nodes.permutation(2).each do |nodes|
          conductances[node_indices[nodes[0]], node_indices[nodes[1]]] -= component.conductance
        end
      end

      components.select(&:current_source?).each do |component|
        currents[node_indices[component.nodes[0]], 0] += component.current
        currents[node_indices[component.nodes[1]], 0] -= component.current
      end

      components.select(&:voltage_source?).each.with_index(offset) do |component, voltage_source_index|
        conductances[node_indices[component.nodes[0]], voltage_source_index] -= 1
        conductances[voltage_source_index, node_indices[component.nodes[0]]] -= 1
        conductances[node_indices[component.nodes[1]], voltage_source_index] += 1
        conductances[voltage_source_index, node_indices[component.nodes[1]]] += 1
        currents[voltage_source_index, 0] = component.voltage
      end

      [conductances, currents]
    end

    def voltages
      conductances, currents = modified_nodal_analysis
      conductances.inverse * currents
    end
  end
end
