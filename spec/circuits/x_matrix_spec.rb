# frozen_string_literal: true

require('circuits/x_matrix')
require('yaml')

RSpec.describe(Circuits::XMatrix) do
  subject :x_matrix do
    described_class.new(a_matrix_to_matrix, b_matrix_to_matrix)
  end

  let :a_matrix_to_matrix do
    YAML.load_file('spec/fixtures/circuits/a_matrix_to_matrix.yaml')
  end

  let :b_matrix_to_matrix do
    YAML.load_file('spec/fixtures/circuits/b_matrix_to_matrix.yaml')
  end

  describe '#to_matrix' do
    subject :to_matrix do
      x_matrix.to_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/x_matrix_to_matrix.yaml'))) }
  end
end
