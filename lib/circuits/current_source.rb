# frozen_string_literal: true

module Circuits
  class CurrentSource
    attr_reader :nodes
    attr_reader :current

    def initialize(nodes, current)
      @nodes = nodes
      @current = current
    end
  end
end
