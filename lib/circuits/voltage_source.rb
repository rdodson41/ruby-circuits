# frozen_string_literal: true

module Circuits
  class VoltageSource
    attr_reader :nodes
    attr_reader :voltage

    def initialize(nodes, voltage)
      @nodes = nodes
      @voltage = voltage
    end

    def hash
      [nodes, voltage].hash
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:voltage) && voltage == other.voltage
    end

    def eql?(other)
      other.respond_to?(:nodes) && nodes.eql?(other.nodes) &&
        other.respond_to?(:voltage) && voltage.eql?(other.voltage)
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
