# frozen_string_literal: true

require('circuits/resistor')

module Circuits
  class Ground < Resistor
    def initialize(id, nodes)
      super(id, nodes, 0)
    end

    def voltage_source?
      false
    end
  end
end
