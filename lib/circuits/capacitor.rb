# frozen_string_literal: true

module Circuits
  class Capacitor
    attr_reader :nodes
    attr_reader :capacitance

    def initialize(nodes, capacitance)
      @nodes = nodes
      @capacitance = capacitance
    end

    def hash
      [nodes, capacitance].hash
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:capacitance) && capacitance == other.capacitance
    end

    def eql?(other)
      other.respond_to?(:nodes) && nodes.eql?(other.nodes) &&
        other.respond_to?(:capacitance) && capacitance.eql?(other.capacitance)
    end

    def conductor?
      false
    end

    def current_source?
      false
    end

    def voltage_source?
      false
    end
  end
end
