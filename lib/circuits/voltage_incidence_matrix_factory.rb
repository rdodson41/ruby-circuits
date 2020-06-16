# frozen_string_literal: true

require('matrix')

module Circuits
  class VoltageIncidenceMatrixFactory
    attr_reader :nodes
    attr_reader :voltage_sources

    def initialize(nodes, voltage_sources)
      @nodes = nodes
      @voltage_sources = voltage_sources
    end

    def voltage_incidence_matrix
      voltage_sources.each_with_index.with_object(zero_matrix) do |(voltage_source, column), matrix|
        voltage_source.nodes.map(&index_nodes).zip([-1, 1]) do |row, orientation|
          matrix[row, column] += orientation
        end
      end
    end

    private

    def zero_matrix
      Matrix.zero(nodes.length, voltage_sources.length)
    end

    def index_nodes
      nodes.method(:index)
    end
  end
end
