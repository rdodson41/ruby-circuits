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

    def hash
      [nodes, resistance].hash
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:resistance) && resistance == other.resistance
    end

    def eql?(other)
      other.respond_to?(:nodes) && nodes.eql?(other.nodes) &&
        other.respond_to?(:resistance) && resistance.eql?(other.resistance)
    end

    def conductor?
      true
    end

    def current_source?
      false
    end

    def voltage_source?
      false
    end
  end
end
