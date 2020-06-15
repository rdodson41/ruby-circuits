# frozen_string_literal: true

require('circuits/inductor')

RSpec.describe(Circuits::Inductor) do
  subject :inductor do
    described_class.new(nodes, 1e-9)
  end

  let :nodes do
    instance_double(Array)
  end

  describe '#voltage' do
    subject :voltage do
      inductor.voltage
    end

    it { is_expected.to(eq(0)) }
  end

  describe '#hash' do
    subject :hash do
      inductor.hash
    end

    let :other do
      described_class.new(nodes, 1e-9)
    end

    it { is_expected.to(eq(other.hash)) }
  end

  describe '#==' do
    let :other do
      described_class.new(nodes, 1e-9)
    end

    it { is_expected.to(eq(other)) }
  end

  describe '#eql?' do
    let :other do
      described_class.new(nodes, 1e-9)
    end

    it { is_expected.to(eql(other)) }
  end

  describe '#conductor?' do
    subject :conductor? do
      inductor.conductor?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#current_source?' do
    subject :current_source? do
      inductor.current_source?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#voltage_source?' do
    subject :voltage_source? do
      inductor.voltage_source?
    end

    it { is_expected.to(be(true)) }
  end
end
