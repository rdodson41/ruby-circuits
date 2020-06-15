# frozen_string_literal: true

require('circuits/x_matrix_factory')
require('yaml')

RSpec.describe(Circuits::XMatrixFactory) do
  subject :x_matrix_factory do
    YAML.load_file('spec/fixtures/circuits/x_matrix_factory.yaml')
  end

  describe '#x_matrix' do
    subject :x_matrix do
      x_matrix_factory.x_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/x_matrix.yaml'))) }
  end
end
