# frozen_string_literal: true

require('circuits/capacitor')
require('circuits/current_source')
require('circuits/ground')
require('circuits/inductor')
require('circuits/network')
require('circuits/resistor')
require('circuits/voltage_source')
require('yaml')

RSpec.describe(Circuits::Network) do
  subject :network do
    described_class.new(components)
  end

  let :components do
    YAML.load_file('spec/fixtures/circuits/components.yaml')
  end

  describe '#nodes' do
    subject :nodes do
      network.nodes
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/nodes.yaml'))) }
  end

  describe '#conductors' do
    subject :conductors do
      network.conductors
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/conductors.yaml'))) }
  end

  describe '#current_sources' do
    subject :current_sources do
      network.current_sources
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/current_sources.yaml'))) }
  end

  describe '#voltage_sources' do
    subject :voltage_sources do
      network.voltage_sources
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/voltage_sources.yaml'))) }
  end

  describe '#conductance_matrix' do
    subject :conductance_matrix do
      network.conductance_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/conductance_matrix.yaml'))) }
  end

  describe '#voltage_incidence_matrix' do
    subject :voltage_incidence_matrix do
      network.voltage_incidence_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/voltage_incidence_matrix.yaml'))) }
  end

  describe '#a_matrix' do
    subject :a_matrix do
      network.a_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/a_matrix.yaml'))) }
  end

  describe '#current_matrix' do
    subject :current_matrix do
      network.current_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/current_matrix.yaml'))) }
  end

  describe '#voltage_matrix' do
    subject :voltage_matrix do
      network.voltage_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/voltage_matrix.yaml'))) }
  end

  describe '#b_matrix' do
    subject :b_matrix do
      network.b_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/b_matrix.yaml'))) }
  end

  describe '#x_matrix' do
    subject :x_matrix do
      network.x_matrix
    end

    it { is_expected.to(eq(YAML.load_file('spec/fixtures/circuits/x_matrix.yaml'))) }
  end
end
