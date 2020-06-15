# frozen_string_literal: true

require('matrix')

module Circuits
  class XMatrix
    attr_reader :a_matrix
    attr_reader :b_matrix

    def initialize(a_matrix, b_matrix)
      @a_matrix = a_matrix
      @b_matrix = b_matrix
    end

    def to_matrix
      a_matrix.inverse * b_matrix
    end
  end
end
