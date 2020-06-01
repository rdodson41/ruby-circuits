# frozen_string_literal: true

require('circuits')

RSpec.describe(Network) do
  subject :network do
    described_class.new(nodes, components)
  end

  let :nodes do
    [
      Node.new('V0', {}),
      Node.new('V1', {}),
      Node.new('V2', {}),
      Node.new('V3', {})
    ]
  end

  let :components do
    [
      Ground.new('GR', { 0 => nodes[0] }),
      VoltageSource.new('VA', { 0 => nodes[0], 1 => nodes[1] }, 1),
      Resistor.new('R1', { 0 => nodes[1], 1 => nodes[2] }, 1000),
      Resistor.new('R2', { 0 => nodes[2], 1 => nodes[3] }, 1000),
      Resistor.new('R3', { 0 => nodes[3], 1 => nodes[0] }, 1000)
    ]
  end

  describe '#voltages' do
    subject :voltages do
      network.voltages.round(3)
    end

    it { is_expected.to(eq(Matrix[[0.0], [1.0], [0.667], [0.333], [0.0]])) }
  end
end
