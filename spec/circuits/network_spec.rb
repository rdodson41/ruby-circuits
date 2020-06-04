# frozen_string_literal: true

require('circuits/capacitor')
require('circuits/current_source')
require('circuits/ground')
require('circuits/inductor')
require('circuits/network')
require('circuits/resistor')
require('circuits/voltage_source')

RSpec.describe(Circuits::Network) do
  subject :network do
    described_class.new(components)
  end

  describe '#voltages' do
    subject :voltages do
      network.voltages.round(3)
    end

    context 'with resistors and a voltage source' do
      let :components do
        [
          Circuits::Ground.new('G1', [0]),
          Circuits::VoltageSource.new('V1', [0, 1], 1),
          Circuits::Resistor.new('R1', [1, 2], 1000),
          Circuits::Resistor.new('R2', [2, 3], 1000),
          Circuits::Resistor.new('R3', [3, 0], 1000)
        ]
      end

      it { is_expected.to(eq(Matrix[[0.0], [1.0], [0.667], [0.333], [0.0]])) }
    end

    context 'with resistors, a voltage source, and a current source' do
      let :components do
        [
          Circuits::Ground.new('G1', [0]),
          Circuits::Resistor.new('R1', [1, 2], 4),
          Circuits::Resistor.new('R2', [2, 0], 2),
          Circuits::VoltageSource.new('V1', [0, 1], 3),
          Circuits::CurrentSource.new('I1', [2, 0], 2)
        ]
      end

      it { is_expected.to(eq(Matrix[[0.0], [3.0], [3.667], [0.167]])) }
    end

    context 'with components of each type' do
      let :components do
        [
          Circuits::Ground.new('G1', [0]),
          Circuits::VoltageSource.new('V1', [0, 5], 2),
          Circuits::VoltageSource.new('V2', [2, 3], 0.2),
          Circuits::VoltageSource.new('V3', [6, 7], 2),
          Circuits::Resistor.new('R1', [1, 5], 1.5),
          Circuits::Resistor.new('R2', [1, 12], 1),
          Circuits::Resistor.new('R3', [5, 2], 50),
          Circuits::Resistor.new('R4', [5, 6], 0.1),
          Circuits::Resistor.new('R5', [2, 6], 1.5),
          Circuits::Resistor.new('R6', [3, 4], 0.2),
          Circuits::Resistor.new('R7', [7, 0], 1e3),
          Circuits::Resistor.new('R8', [4, 0], 10),
          Circuits::CurrentSource.new('I1', [7, 4], 1e-3),
          Circuits::CurrentSource.new('I2', [6, 0], 1e-3),
          Circuits::Capacitor.new('C1', [7, 0], 0.1),
          Circuits::Capacitor.new('C2', [2, 0], 0.2),
          Circuits::Inductor.new('L1', [2, 12], 0.1)
        ]
      end

      it do
        expect(voltages).to(eq(Matrix[[0.0],
                                      [2.0],
                                      [1.81],
                                      [2.01],
                                      [1.988],
                                      [3.988],
                                      [1.886],
                                      [1.81],
                                      [1.971],
                                      [-0.2],
                                      [-0.198],
                                      [-0.003],
                                      [0.076]]))
      end
    end
  end
end
