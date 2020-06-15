# frozen_string_literal: true

module Circuits
  class Capacitor
    attr_reader :nodes
    attr_reader :capacitance

    def initialize(nodes, capacitance)
      @nodes = nodes
      @capacitance = capacitance
    end
  end
end
