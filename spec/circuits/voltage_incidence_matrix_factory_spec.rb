# frozen_string_literal: true

require('circuits/inductor')
require('circuits/voltage_incidence_matrix_factory')
require('circuits/voltage_source')
require('yaml')

RSpec.describe(Circuits::VoltageIncidenceMatrixFactory) do
  subject :voltage_incidence_matrix_factory do
    described_class.new(nodes, voltage_sources)
  end

  let :nodes do
    YAML.load_file('spec/fixtures/circuits/nodes.yaml')
  end

  let :voltage_sources do
    YAML.load_file('spec/fixtures/circuits/voltage_sources.yaml')
  end

  describe '#voltage_incidence_matrix' do
    subject :voltage_incidence_matrix do
      voltage_incidence_matrix_factory.voltage_incidence_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/voltage_incidence_matrix.yaml'))) }
  end
end
