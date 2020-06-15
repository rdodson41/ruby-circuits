# frozen_string_literal: true

require('circuits/capacitor')

RSpec.describe(Circuits::Capacitor) do
  subject :capacitor do
    described_class.new(nodes, 1e-6)
  end

  let :nodes do
    instance_double(Array)
  end

  describe '#==' do
    let :other do
      described_class.new(nodes, 1e-6)
    end

    it { is_expected.to(eq(other)) }
  end
end
