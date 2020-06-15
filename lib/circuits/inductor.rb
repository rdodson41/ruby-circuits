# frozen_string_literal: true

module Circuits
  class Inductor
    attr_reader :nodes
    attr_reader :inductance

    def initialize(nodes, inductance)
      @nodes = nodes
      @inductance = inductance
    end

    def voltage
      0
    end

    def hash
      [nodes, inductance].hash
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:inductance) && inductance == other.inductance
    end

    def eql?(other)
      other.respond_to?(:nodes) && nodes.eql?(other.nodes) &&
        other.respond_to?(:inductance) && inductance.eql?(other.inductance)
    end

    def conductor?
      false
    end

    def current_source?
      false
    end

    def voltage_source?
      true
    end
  end
end
