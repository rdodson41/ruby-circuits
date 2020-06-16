# frozen_string_literal: true

require('circuits/a_matrix_factory')
require('yaml')

RSpec.describe(Circuits::AMatrixFactory) do
  subject :a_matrix_factory do
    described_class.new(conductance_matrix, voltage_incidence_matrix)
  end

  let :conductance_matrix do
    YAML.load_file('spec/fixtures/circuits/conductance_matrix.yaml')
  end

  let :voltage_incidence_matrix do
    YAML.load_file('spec/fixtures/circuits/voltage_incidence_matrix.yaml')
  end

  describe '#a_matrix' do
    subject :a_matrix do
      a_matrix_factory.a_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/a_matrix.yaml'))) }
  end
end
