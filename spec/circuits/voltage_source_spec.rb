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

  describe '#conductor?' do
    subject :conductor? do
      voltage_source.conductor?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#current_source?' do
    subject :current_source? do
      voltage_source.current_source?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#voltage_source?' do
    subject :voltage_source? do
      voltage_source.voltage_source?
    end

    it { is_expected.to(be(true)) }
  end
end
