# frozen_string_literal: true

require('circuits/current_source')

RSpec.describe(Circuits::CurrentSource) do
  subject :current_source do
    described_class.new(nodes, 1e-3)
  end

  let :nodes do
    instance_double(Array)
  end

  describe '#==' do
    let :other do
      described_class.new(nodes, 1e-3)
    end

    it { is_expected.to(eq(other)) }
  end
end
