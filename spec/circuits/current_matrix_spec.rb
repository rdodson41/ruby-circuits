# frozen_string_literal: true

require('circuits/current_matrix')
require('circuits/current_source')
require('yaml')

RSpec.describe(Circuits::CurrentMatrix) do
  subject :current_matrix do
    YAML.load_file('spec/fixtures/circuits/current_matrix.yaml')
  end

  describe '#to_matrix' do
    subject :to_matrix do
      current_matrix.to_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/current_matrix_to_matrix.yaml'))) }
  end
end
