# frozen_string_literal: true

module Circuits
  class VoltageSource
    attr_reader :nodes
    attr_reader :voltage

    def initialize(nodes, voltage)
      @nodes = nodes
      @voltage = voltage
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:voltage) && voltage == other.voltage
    end
  end
end
