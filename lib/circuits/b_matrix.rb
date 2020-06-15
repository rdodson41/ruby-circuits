# frozen_string_literal: true

require('matrix')

module Circuits
  class BMatrix
    attr_reader :current_matrix
    attr_reader :voltage_matrix

    def initialize(current_matrix, voltage_matrix)
      @current_matrix = current_matrix
      @voltage_matrix = voltage_matrix
    end

    def to_matrix
      Matrix.vstack(current_matrix, voltage_matrix)
    end
  end
end
