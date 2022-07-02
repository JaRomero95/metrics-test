# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metric, type: :model do
  describe 'Validations' do
    let(:instance) { build :metric }

    describe 'name' do
      it 'is required' do
        instance.name = nil

        expect(instance).to be_invalid
      end
    end

    describe 'value' do
      it 'is required' do
        instance.value = nil

        expect(instance).to be_invalid
      end

      it 'should be a number' do
        instance.value = 'loremipsum'

        expect(instance).to be_invalid
      end
    end

    describe 'timestamp' do
      it 'is required' do
        instance.timestamp = nil

        expect(instance).to be_invalid
      end
    end
  end

  describe 'Filters' do
    let(:timestamp) { Time.zone.now }
    let(:present_instance) { create :metric, timestamp: }
    let(:past_instance) { create :metric, timestamp: (timestamp - 1.minute) }
    let(:future_instance) { create :metric, timestamp: (timestamp + 1.minute) }

    describe 'datetime_from' do
      it 'includes metrics from the indicated datetime' do
        result = described_class.datetime_from(timestamp)

        expect(result).to include(future_instance)
      end

      it 'includes metrics on the exact indicated datetime' do
        result = described_class.datetime_from(timestamp)

        expect(result).to include(present_instance)
      end

      it 'does not includes metrics previous to the indicated datetime' do
        result = described_class.datetime_from(timestamp)

        expect(result).not_to include(past_instance)
      end
    end

    describe 'datetime_until' do
      it 'includes metrics previous to the indicated datetime' do
        result = described_class.datetime_until(timestamp)

        expect(result).to include(past_instance)
      end

      it 'includes metrics on the exact indicated datetime' do
        result = described_class.datetime_until(timestamp)

        expect(result).to include(present_instance)
      end

      it 'does not includes metrics future to the indicated datetime' do
        result = described_class.datetime_until(timestamp)

        expect(result).not_to include(future_instance)
      end
    end
  end
end
