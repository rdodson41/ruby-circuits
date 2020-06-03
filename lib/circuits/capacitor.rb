# frozen_string_literal: true

require('circuits/component')

module Circuits
  class Capacitor < Component
    attr_reader :capacitance

    def initialize(id, nodes, capacitance)
      super(id, nodes)
      @capacitance = Float(capacitance)
    end

    def voltage_source?
      false
    end
  end
end
