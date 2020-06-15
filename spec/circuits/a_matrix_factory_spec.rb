# frozen_string_literal: true

require('circuits/a_matrix_factory')
require('yaml')

RSpec.describe(Circuits::AMatrixFactory) do
  subject :a_matrix_factory do
    YAML.load_file('spec/fixtures/circuits/a_matrix_factory.yaml')
  end

  describe '#a_matrix' do
    subject :a_matrix do
      a_matrix_factory.a_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/a_matrix.yaml'))) }
  end
end
