# frozen_string_literal: true

require('circuits/modified_nodal_analysis/a_matrix')
require('circuits/modified_nodal_analysis/b_matrix')
require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class XMatrix < SimpleDelegator
      attr_reader :components

      def initialize(components)
        @components = components
        super(x_matrix)
      end

      def a_matrix
        ModifiedNodalAnalysis::AMatrix.new(components)
      end

      def b_matrix
        ModifiedNodalAnalysis::BMatrix.new(components)
      end

      private

      def x_matrix
        a_matrix.inverse * b_matrix.to_matrix
      end
    end
  end
end
