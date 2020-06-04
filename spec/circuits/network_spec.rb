# frozen_string_literal: true

require('circuits/network')
require('yaml')

RSpec.describe(Circuits::Network) do
  let :fixtures do
    Pathname.new('spec/fixtures/circuits/networks')
  end

  describe '#voltages' do
    subject :voltages do
      network.voltages.round(3)
    end

    context 'with resistors and a voltage source' do
      let :network do
        YAML.load_file(fixtures / 'example0.yaml')
      end

      it { is_expected.to(eq(YAML.load_file(fixtures / 'voltages' / 'example0.yaml'))) }
    end

    context 'with resistors, a voltage source, and a current source' do
      let :network do
        YAML.load_file(fixtures / 'example1.yaml')
      end

      it { is_expected.to(eq(YAML.load_file(fixtures / 'voltages' / 'example1.yaml'))) }
    end

    context 'with components of each type' do
      let :network do
        YAML.load_file(fixtures / 'example2.yaml')
      end

      it { is_expected.to(eq(YAML.load_file(fixtures / 'voltages' / 'example2.yaml'))) }
    end
  end
end
