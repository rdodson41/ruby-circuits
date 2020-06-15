# frozen_string_literal: true

module Circuits
  class VoltageSource
    attr_reader :nodes
    attr_reader :voltage

    def initialize(nodes, voltage)
      @nodes = nodes
      @voltage = voltage
    end
  end
end
