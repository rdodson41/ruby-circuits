# frozen_string_literal: true

require('circuits/voltage_source')

RSpec.describe(Circuits::VoltageSource) do
  subject :voltage_source do
    described_class.new(nodes, 1)
  end

  let :nodes do
    instance_double(Array)
  end

  describe '#==' do
    let :other do
      described_class.new(nodes, 1)
    end

    it { is_expected.to(eq(other)) }
  end
end
