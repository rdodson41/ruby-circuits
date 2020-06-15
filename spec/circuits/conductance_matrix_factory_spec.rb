# frozen_string_literal: true

require('circuits/conductance_matrix_factory')
require('circuits/ground')
require('circuits/resistor')
require('yaml')

RSpec.describe(Circuits::ConductanceMatrixFactory) do
  subject :conductance_matrix_factory do
    YAML.load_file('spec/fixtures/circuits/conductance_matrix_factory.yaml')
  end

  describe '#conductance_matrix' do
    subject :conductance_matrix do
      conductance_matrix_factory.conductance_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/conductance_matrix.yaml'))) }
  end
end
