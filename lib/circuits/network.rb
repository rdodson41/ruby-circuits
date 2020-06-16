# frozen_string_literal: true

require('circuits/a_matrix_factory')
require('circuits/conductance_matrix_factory')
require('circuits/current_matrix_factory')
require('circuits/voltage_incidence_matrix_factory')
require('matrix')

module Circuits
  class Network
    attr_reader :components

    def initialize(components)
      @components = components
    end

    def nodes
      components.flat_map(&:nodes).uniq
    end

    def conductors
      components.select(&:conductor?)
    end

    def current_sources
      components.select(&:current_source?)
    end

    def voltage_sources
      components.select(&:voltage_source?)
    end

    def conductance_matrix
      conductance_matrix_factory.conductance_matrix
    end

    def voltage_incidence_matrix
      voltage_incidence_matrix_factory.voltage_incidence_matrix
    end

    def a_matrix
      a_matrix_factory.a_matrix
    end

    def current_matrix
      current_matrix_factory.current_matrix
    end

    def voltage_matrix
      Matrix.column_vector(voltages)
    end

    def b_matrix
      Matrix.vstack(current_matrix, voltage_matrix)
    end

    def x_matrix
      a_matrix.inverse * b_matrix
    end

    private

    def conductance_matrix_factory
      ConductanceMatrixFactory.new(nodes, conductors)
    end

    def voltage_incidence_matrix_factory
      VoltageIncidenceMatrixFactory.new(nodes, voltage_sources)
    end

    def a_matrix_factory
      AMatrixFactory.new(conductance_matrix, voltage_incidence_matrix)
    end

    def current_matrix_factory
      CurrentMatrixFactory.new(nodes, current_sources)
    end

    def voltages
      voltage_sources.map(&:voltage)
    end
  end
end
