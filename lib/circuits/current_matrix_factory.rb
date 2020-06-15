# frozen_string_literal: true

require('matrix')

module Circuits
  class CurrentMatrixFactory
    attr_reader :nodes
    attr_reader :current_sources

    def initialize(nodes, current_sources)
      @nodes = nodes
      @current_sources = current_sources
    end

    def current_matrix
      current_sources.each_with_object(zero_matrix) do |current_source, matrix|
        anode_index, cathode_index = current_source.nodes.map(&index_nodes)
        matrix[anode_index, 0] -= current_source.current
        matrix[cathode_index, 0] += current_source.current
      end
    end

    private

    def zero_matrix
      Matrix.zero(nodes.length, 1)
    end

    def index_nodes
      nodes.method(:index)
    end
  end
end
