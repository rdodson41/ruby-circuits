# frozen_string_literal: true

require('circuits/network')
require('yaml')

RSpec.describe(Circuits::Network) do
  let :fixtures do
    Pathname.new('spec/fixtures/circuits/networks')
  end

  describe '#modified_nodal_analysis_x_matrix' do
    subject :modified_nodal_analysis_x_matrix do
      network.modified_nodal_analysis_x_matrix.round(3)
    end

    context 'with resistors and a voltage source' do
      let :network do
        YAML.load_file(fixtures / 'example0.yaml')
      end

      it { is_expected.to(eq(YAML.load_file(fixtures / 'modified_nodal_analysis_x_matrix' / 'example0.yaml'))) }
    end

    context 'with resistors, a voltage source, and a current source' do
      let :network do
        YAML.load_file(fixtures / 'example1.yaml')
      end

      it { is_expected.to(eq(YAML.load_file(fixtures / 'modified_nodal_analysis_x_matrix' / 'example1.yaml'))) }
    end

    context 'with components of each type' do
      let :network do
        YAML.load_file(fixtures / 'example2.yaml')
      end

      it { is_expected.to(eq(YAML.load_file(fixtures / 'modified_nodal_analysis_x_matrix' / 'example2.yaml'))) }
    end
  end
end
