# frozen_string_literal: true

require('circuits/component')

module Circuits
  class Resistor < Component
    attr_reader :resistance

    def initialize(id, nodes, resistance)
      super(id, nodes)
      @resistance = Float(resistance)
    end

    def conductance
      1 / resistance
    end

    def conductor?
      true
    end
  end
end
