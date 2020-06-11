# frozen_string_literal: true

module Circuits
  class Resistor
    attr_reader :nodes
    attr_reader :resistance

    def initialize(nodes, resistance)
      @nodes = nodes
      @resistance = resistance
    end

    def conductance
      1 / Float(resistance)
    end
  end
end
