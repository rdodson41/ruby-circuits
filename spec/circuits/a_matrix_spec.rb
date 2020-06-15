# frozen_string_literal: true

require('circuits/a_matrix')
require('yaml')

RSpec.describe(Circuits::AMatrix) do
  subject :a_matrix do
    described_class.new(conductance_matrix_to_matrix, voltage_incidence_matrix_to_matrix)
  end

  let :conductance_matrix_to_matrix do
    YAML.load_file('spec/fixtures/circuits/conductance_matrix_to_matrix.yaml')
  end

  let :voltage_incidence_matrix_to_matrix do
    YAML.load_file('spec/fixtures/circuits/voltage_incidence_matrix_to_matrix.yaml')
  end

  describe '#to_matrix' do
    subject :to_matrix do
      a_matrix.to_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/a_matrix_to_matrix.yaml'))) }
  end
end
