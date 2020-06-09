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

      def modified_nodal_analysis_a_matrix
        ModifiedNodalAnalysis::AMatrix.new(components)
      end

      def modified_nodal_analysis_b_matrix
        ModifiedNodalAnalysis::BMatrix.new(components)
      end

      private

      def x_matrix
        modified_nodal_analysis_a_matrix.inverse * modified_nodal_analysis_b_matrix.to_matrix
      end
    end
  end
end
