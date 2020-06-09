# frozen_string_literal: true

require('circuits/component')

module Circuits
  class Ground < Component
    def conductance
      Float::INFINITY
    end

    def conductor?
      true
    end
  end
end
