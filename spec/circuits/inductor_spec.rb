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

  describe '#==' do
    let :other do
      described_class.new(nodes, 1e-9)
    end

    it { is_expected.to(eq(other)) }
  end
end
