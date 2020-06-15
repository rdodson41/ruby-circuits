# frozen_string_literal: true

require('circuits/resistor')

RSpec.describe(Circuits::Resistor) do
  subject :resistor do
    described_class.new(nodes, 1e3)
  end

  let :nodes do
    instance_double(Array)
  end

  describe '#conductance' do
    subject :conductance do
      resistor.conductance
    end

    it { is_expected.to(eq(1e-3)) }
  end

  describe '#==' do
    let :other do
      described_class.new(nodes, 1e3)
    end

    it { is_expected.to(eq(other)) }
  end

  describe '#conductor?' do
    subject :conductor? do
      resistor.conductor?
    end

    it { is_expected.to(be(true)) }
  end

  describe '#current_source?' do
    subject :current_source? do
      resistor.current_source?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#voltage_source?' do
    subject :voltage_source? do
      resistor.voltage_source?
    end

    it { is_expected.to(be(false)) }
  end
end
