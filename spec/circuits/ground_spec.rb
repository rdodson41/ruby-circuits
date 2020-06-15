# frozen_string_literal: true

require('circuits/ground')

RSpec.describe(Circuits::Ground) do
  subject :ground do
    described_class.new(node)
  end

  let :node do
    instance_double(Integer)
  end

  describe '#nodes' do
    subject :nodes do
      ground.nodes
    end

    it { is_expected.to(eq([node])) }
  end

  describe '#conductance' do
    subject :conductance do
      ground.conductance
    end

    it { is_expected.to(eq(Float::INFINITY)) }
  end

  describe '#==' do
    let :other do
      described_class.new(node)
    end

    it { is_expected.to(eq(other)) }
  end

  describe '#conductor?' do
    subject :conductor? do
      ground.conductor?
    end

    it { is_expected.to(be(true)) }
  end

  describe '#current_source?' do
    subject :current_source? do
      ground.current_source?
    end

    it { is_expected.to(be(false)) }
  end

  describe '#voltage_source?' do
    subject :voltage_source? do
      ground.voltage_source?
    end

    it { is_expected.to(be(false)) }
  end
end
