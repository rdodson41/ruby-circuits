# frozen_string_literal: true

require('circuits/inductor')
require('circuits/voltage_incidence_matrix')
require('circuits/voltage_source')
require('yaml')

RSpec.describe(Circuits::VoltageIncidenceMatrix) do
  subject :voltage_incidence_matrix do
    YAML.load_file('spec/fixtures/circuits/voltage_incidence_matrix.yaml')
  end

  describe '#to_matrix' do
    subject :to_matrix do
      voltage_incidence_matrix.to_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/voltage_incidence_matrix_to_matrix.yaml'))) }
  end
end
