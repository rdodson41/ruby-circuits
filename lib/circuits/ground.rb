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

    def hash
      node.hash
    end

    def ==(other)
      other.respond_to?(:node) && node == other.node
    end

    def eql?(other)
      other.respond_to?(:nodes) && node.eql?(other.node)
    end

    def conductor?
      true
    end

    def current_source?
      false
    end

    def voltage_source?
      false
    end
  end
end
