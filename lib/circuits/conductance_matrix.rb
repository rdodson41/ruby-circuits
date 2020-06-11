# frozen_string_literal: true

require('matrix')

module Circuits
  class ConductanceMatrix
    attr_reader :nodes
    attr_reader :conductors

    def initialize(nodes, conductors)
      @nodes = nodes
      @conductors = conductors
    end

    def to_matrix
      conductors.each_with_object(zero_matrix) do |conductor, matrix|
        conductor_nodes_indices = conductor.nodes.map(&index_nodes)
        conductor_nodes_indices.zip(conductor_nodes_indices) do |row, column|
          matrix[row, column] += conductor.conductance
        end
        conductor_nodes_indices.permutation(2) do |row, column|
          matrix[row, column] -= conductor.conductance
        end
      end
    end

    private

    def zero_matrix
      Matrix.zero(nodes.length)
    end

    def index_nodes
      nodes.method(:index)
    end
  end
end
