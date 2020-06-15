# frozen_string_literal: true

require('circuits/b_matrix_factory')
require('yaml')

RSpec.describe(Circuits::BMatrixFactory) do
  subject :b_matrix_factory do
    YAML.load_file('spec/fixtures/circuits/b_matrix_factory.yaml')
  end

  describe '#b_matrix' do
    subject :b_matrix do
      b_matrix_factory.b_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/b_matrix.yaml'))) }
  end
end
