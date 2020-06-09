# frozen_string_literal: true

require('circuits/modified_nodal_analysis/x_matrix')

module Circuits
  class Network
    attr_reader :components

    def initialize(components)
      @components = components
    end

    def nodes
      @nodes ||= components.flat_map(&:nodes).uniq
    end

    def nodes_indices
      @nodes_indices ||= nodes.map.with_index.to_h
    end

    def x_matrix
      ModifiedNodalAnalysis::XMatrix.new(components, nodes_indices)
    end
  end
end
