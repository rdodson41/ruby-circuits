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
        current_source.nodes.map(&index_nodes).zip([-1, 1]) do |row, orientation|
          matrix[row, 0] += orientation * current_source.current
        end
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
