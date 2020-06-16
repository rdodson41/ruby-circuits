# frozen_string_literal: true

require('circuits/current_matrix_factory')
require('circuits/current_source')
require('yaml')

RSpec.describe(Circuits::CurrentMatrixFactory) do
  subject :current_matrix_factory do
    described_class.new(nodes, current_sources)
  end

  let :nodes do
    YAML.load_file('spec/fixtures/circuits/nodes.yaml')
  end

  let :current_sources do
    YAML.load_file('spec/fixtures/circuits/current_sources.yaml')
  end

  describe '#current_matrix' do
    subject :current_matrix do
      current_matrix_factory.current_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/current_matrix.yaml'))) }
  end
end
