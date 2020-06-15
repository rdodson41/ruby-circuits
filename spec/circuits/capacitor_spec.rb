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

  describe '#conductor?' do
    subject :conductor? do
      capacitor.conductor?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#current_source?' do
    subject :current_source? do
      capacitor.current_source?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#voltage_source?' do
    subject :voltage_source? do
      capacitor.voltage_source?
    end

    it { is_expected.to(be(false)) }
  end
end
