# frozen_string_literal: true

module Circuits
  class Ground
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def nodes
      [node]
    end

    def conductance
      Float::INFINITY
    end

    def ==(other)
      other.respond_to?(:node) && node == other.node
    end
  end
end
