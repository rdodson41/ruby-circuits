# frozen_string_literal: true

require('matrix')

module Circuits
  class AMatrixFactory
    attr_reader :conductance_matrix
    attr_reader :voltage_incidence_matrix

    def initialize(conductance_matrix, voltage_incidence_matrix)
      @conductance_matrix = conductance_matrix
      @voltage_incidence_matrix = voltage_incidence_matrix
    end

    def a_matrix
      Matrix.vstack(upper_a_matrix, lower_a_matrix)
    end

    private

    def upper_a_matrix
      Matrix.hstack(conductance_matrix, voltage_incidence_matrix)
    end

    def d_matrix
      Matrix.zero(voltage_incidence_matrix.column_count)
    end

    def lower_a_matrix
      Matrix.hstack(voltage_incidence_matrix.transpose, d_matrix)
    end
  end
end
