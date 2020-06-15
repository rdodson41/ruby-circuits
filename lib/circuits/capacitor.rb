# frozen_string_literal: true

module Circuits
  class Capacitor
    attr_reader :nodes
    attr_reader :capacitance

    def initialize(nodes, capacitance)
      @nodes = nodes
      @capacitance = capacitance
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:capacitance) && capacitance == other.capacitance
    end
  end
end
