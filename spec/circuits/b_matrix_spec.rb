# frozen_string_literal: true

require('circuits/b_matrix')
require('yaml')

RSpec.describe(Circuits::BMatrix) do
  subject :b_matrix do
    described_class.new(current_matrix, voltage_matrix)
  end

  let :current_matrix do
    YAML.load_file('spec/fixtures/circuits/current_matrix.yaml')
  end

  let :voltage_matrix do
    YAML.load_file('spec/fixtures/circuits/voltage_matrix.yaml')
  end

  describe '#to_matrix' do
    subject :to_matrix do
      b_matrix.to_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/b_matrix_to_matrix.yaml'))) }
  end
end
