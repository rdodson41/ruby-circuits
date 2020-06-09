# frozen_string_literal: true

require('circuits/component')

module Circuits
  class CurrentSource < Component
    attr_reader :current

    def initialize(id, nodes, current)
      super(id, nodes)
      @current = Float(current)
    end

    def voltage_source?
      false
    end

    def current_source?
      true
    end
  end
end
