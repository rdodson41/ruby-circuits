# frozen_string_literal: true

require('circuits/ground')
require('circuits/network')
require('circuits/node')
require('circuits/resistor')
require('circuits/voltage_source')

RSpec.describe(Circuits::Network) do
  subject :network do
    described_class.new(nodes, components)
  end

  let :nodes do
    [
      Circuits::Node.new('V0'),
      Circuits::Node.new('V1'),
      Circuits::Node.new('V2'),
      Circuits::Node.new('V3')
    ]
  end

  let :components do
    [
      Circuits::Ground.new('GR', [nodes[0]]),
      Circuits::VoltageSource.new('VA', [nodes[0], nodes[1]], 1),
      Circuits::Resistor.new('R1', [nodes[1], nodes[2]], 1000),
      Circuits::Resistor.new('R2', [nodes[2], nodes[3]], 1000),
      Circuits::Resistor.new('R3', [nodes[3], nodes[0]], 1000)
    ]
  end

  describe '#voltages' do
    subject :voltages do
      network.voltages.round(3)
    end

    it { is_expected.to(eq(Matrix[[0.0], [1.0], [0.667], [0.333], [0.0]])) }
  end
end
