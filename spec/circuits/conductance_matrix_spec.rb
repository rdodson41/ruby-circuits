# frozen_string_literal: true

require('circuits/conductance_matrix')
require('circuits/ground')
require('circuits/resistor')
require('yaml')

RSpec.describe(Circuits::ConductanceMatrix) do
  subject :conductance_matrix do
    YAML.load_file('spec/fixtures/circuits/conductance_matrix.yaml')
  end

  describe '#to_matrix' do
    subject :to_matrix do
      conductance_matrix.to_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/conductance_matrix_to_matrix.yaml'))) }
  end
end
