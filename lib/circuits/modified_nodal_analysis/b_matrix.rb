# frozen_string_literal: true

require('circuits/modified_nodal_analysis/voltage_matrix')
require('circuits/nodal_analysis/current_matrix')
require('delegate')
require('matrix')

module Circuits
  module ModifiedNodalAnalysis
    class BMatrix < SimpleDelegator
      attr_reader :components
      attr_reader :nodes_indices

      def initialize(components, nodes_indices)
        @components = components
        @nodes_indices = nodes_indices
        super(b_matrix)
      end

      def current_matrix
        NodalAnalysis::CurrentMatrix.new(components, nodes_indices)
      end

      def voltage_matrix
        ModifiedNodalAnalysis::VoltageMatrix.new(components)
      end

      private

      def b_matrix
        Matrix.vstack(current_matrix, voltage_matrix)
      end
    end
  end
end
