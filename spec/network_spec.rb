# frozen_string_literal: true

require('circuits')

RSpec.describe(Network) do
  subject :network do
    described_class.new(nodes, components)
  end

  let :nodes do
    %w[V0 V1 V2 V3].map(&Node.method(:new))
  end

  let :components do
    [
      VoltageSource.new('VA', { 0 => nodes[0], 1 => nodes[1] }, 1),
      Resistor.new('R1', { 0 => nodes[1], 1 => nodes[2] }, 1000),
      Resistor.new('R2', { 0 => nodes[2], 1 => nodes[3] }, 1000),
      Resistor.new('R3', { 0 => nodes[3], 1 => nodes[0] }, 1000)
    ]
  end

  describe '#voltages' do
    subject :voltages do
      network.voltages
    end

    it { is_expected.to(eq(Matrix[[1.0], [0.6666666666666666], [0.3333333333333333], [-0.0003333333333333334]])) }
  end
end
