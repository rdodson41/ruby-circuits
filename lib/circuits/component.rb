# frozen_string_literal: true

module Circuits
  class Component
    attr_reader :id
    attr_reader :nodes

    def initialize(id, nodes)
      @id = id
      @nodes = nodes
    end

    def voltage
      0.0
    end

    def current_source?
      false
    end

    def conductor?
      false
    end
  end
end
