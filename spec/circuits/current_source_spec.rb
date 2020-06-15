# frozen_string_literal: true

require('circuits/current_source')

RSpec.describe(Circuits::CurrentSource) do
  subject :current_source do
    described_class.new(nodes, 1e-3)
  end

  let :nodes do
    instance_double(Array)
  end

  describe '#hash' do
    subject :hash do
      current_source.hash
    end

    let :other do
      described_class.new(nodes, 1e-3)
    end

    it { is_expected.to(eq(other.hash)) }
  end

  describe '#==' do
    let :other do
      described_class.new(nodes, 1e-3)
    end

    it { is_expected.to(eq(other)) }
  end

  describe '#eql?' do
    let :other do
      described_class.new(nodes, 1e-3)
    end

    it { is_expected.to(eql(other)) }
  end

  describe '#conductor?' do
    subject :conductor? do
      current_source.conductor?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#current_source?' do
    subject :current_source? do
      current_source.current_source?
    end

    it { is_expected.to(be(true)) }
  end

  describe '#voltage_source?' do
    subject :voltage_source? do
      current_source.voltage_source?
    end

    it { is_expected.to(be(false)) }
  end
end
