# frozen_string_literal: true

require('circuits/component')

module Circuits
  class VoltageSource < Component
    attr_reader :voltage

    def initialize(id, nodes, voltage)
      super(id, nodes)
      @voltage = Float(voltage)
    end

    def voltage_source?
      true
    end
  end
end
