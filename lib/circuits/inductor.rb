# frozen_string_literal: true

require('circuits/component')

module Circuits
  class Inductor < Component
    attr_reader :inductance

    def initialize(id, nodes, inductance)
      super(id, nodes)
      @inductance = Float(inductance)
    end

    def voltage
      0.0
    end

    def voltage_source?
      true
    end
  end
end
