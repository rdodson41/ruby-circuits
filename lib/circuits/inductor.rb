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
  end
end
