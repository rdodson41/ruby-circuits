# frozen_string_literal: true

module Circuits
  class CurrentSource
    attr_reader :nodes
    attr_reader :current

    def initialize(nodes, current)
      @nodes = nodes
      @current = current
    end

    def hash
      [nodes, current].hash
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:current) && current == other.current
    end

    def eql?(other)
      other.respond_to?(:nodes) && nodes.eql?(other.nodes) &&
        other.respond_to?(:current) && current.eql?(other.current)
    end

    def conductor?
      false
    end

    def current_source?
      true
    end

    def voltage_source?
      false
    end
  end
end
