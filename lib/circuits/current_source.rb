# frozen_string_literal: true

module Circuits
  class CurrentSource
    attr_reader :nodes
    attr_reader :current

    def initialize(nodes, current)
      @nodes = nodes
      @current = current
    end

    def ==(other)
      other.respond_to?(:nodes) && nodes == other.nodes &&
        other.respond_to?(:current) && current == other.current
    end
  end
end
