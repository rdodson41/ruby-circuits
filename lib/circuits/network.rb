# frozen_string_literal: true

require('circuits/capacitor')
require('circuits/current_source')
require('circuits/ground')
require('circuits/inductor')
require('circuits/modified_nodal_analysis/x_matrix')
require('circuits/resistor')
require('circuits/voltage_source')

module Circuits
  class Network
    attr_reader :components

    def initialize(components)
      @components = components
    end

    def x_matrix
      ModifiedNodalAnalysis::XMatrix.new(components)
    end
  end
end
