# frozen_string_literal: true

require('circuits/modified_nodal_analysis/x_matrix')

module Circuits
  class Network
    attr_reader :components

    def initialize(components)
      @components = components
    end

    def conductors
      components.select(&:conductor?)
    end

    def current_sources
      components.select(&:current_source?)
    end

    def voltage_sources
      components.select(&:voltage_source?)
    end

    def nodes
      components.flat_map(&:nodes).uniq
    end

    def nodes_indices
      nodes.map.with_index.to_h
    end

    def x_matrix
      ModifiedNodalAnalysis::XMatrix.new(conductors, current_sources, voltage_sources, nodes_indices)
    end
  end
end
