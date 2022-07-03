# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupMetricsService do
  delegate :run, to: :described_class

  let!(:repository) { double('MetricsRepository') }

  let(:callable_methods) do
    %i[value_average_by_days value_average_by_hours value_average_by_minutes]
  end

  let(:datetime_from) { 1.day.ago }
  let(:datetime_until) { 2.days.ago }

  before do
    stub_const('MetricsRepository', repository)

    mock_repository_methods callable_methods
  end

  context 'when arguments are valid' do
    it 'calls repository correctly when unit is days' do
      run(group_unit: 'days', datetime_from:, datetime_until:)

      expect(repository).to have_received(:value_average_by_days).with(
        datetime_from:,
        datetime_until:
      )
    end

    it 'calls repository correctly when unit is hours' do
      run(group_unit: 'hours', datetime_from:, datetime_until:)

      expect(repository).to have_received(:value_average_by_hours).with(
        datetime_from:,
        datetime_until:
      )
    end

    it 'calls repository correctly when unit is minutes' do
      run(group_unit: 'minutes', datetime_from:, datetime_until:)

      expect(repository).to have_received(:value_average_by_minutes).with(
        datetime_from:,
        datetime_until:
      )
    end
  end

  context 'when arguments are invalid' do
    let!(:result) { run(group_unit: 'wrong', datetime_from:, datetime_until:) }

    it 'does not call any repository methods' do
      callable_methods.each { |method_name| expect(repository).not_to have_received(method_name) }
    end

    it 'has accesible errors' do
      expect(result.errors.details).not_to be_empty
    end
  end

  def mock_repository_methods(method_names)
    method_names.each do |method_name|
      allow(repository).to receive(method_name).and_return([])
    end
  end
end
