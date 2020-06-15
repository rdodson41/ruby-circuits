# frozen_string_literal: true

require('matrix')

module Circuits
  class AMatrix
    attr_reader :conductance_matrix
    attr_reader :voltage_incidence_matrix

    def initialize(conductance_matrix, voltage_incidence_matrix)
      @conductance_matrix = conductance_matrix
      @voltage_incidence_matrix = voltage_incidence_matrix
    end

    def to_matrix
      Matrix.vstack(
        Matrix.hstack(conductance_matrix, voltage_incidence_matrix),
        Matrix.hstack(voltage_incidence_matrix.transpose, zero_matrix)
      )
    end

    private

    def zero_matrix
      Matrix.zero(voltage_incidence_matrix.column_count)
    end
  end
end
