# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GroupMetrics', type: :request do
  describe 'GET /index' do
    let(:url) { '/group_metrics' }
    let(:group_metrics_service) { double('GroupMetricsService') }

    before do
      allow(GroupMetricsService).to receive(:new).and_return(group_metrics_service)
      allow(group_metrics_service).to receive(:run).and_return(true)
      allow(group_metrics_service).to receive(:result).and_return([])
      allow(group_metrics_service).to receive(:errors).and_return({})
    end

    context 'with valid parameters' do
      let(:params) do
        {
          group_by: 'days',
          filter: {
            datetime_from: 1.day.ago.to_s,
            datetime_until: Time.zone.now.to_s
          }
        }
      end

      before { get url, params: }

      it 'delegates to GroupMetricsService' do
        expected_params = {
          group_by: params[:group_by],
          datetime_from: params[:filter][:datetime_from],
          datetime_until: params[:filter][:datetime_until]
        }

        expect(GroupMetricsService).to have_received(:new).with(expected_params)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns response data' do
        expect(json_response['data']).to eq([])
      end
    end

    context 'with default parameters' do
      before { get url }

      it 'calls GroupMetricsService correctly' do
        expect(GroupMetricsService).to have_received(:new).with(
          hash_including(
            datetime_from: instance_of(ActiveSupport::TimeWithZone),
            datetime_until: instance_of(ActiveSupport::TimeWithZone),
            group_by: 'minutes'
          )
        )
      end
    end

    context 'with invalid parameters' do
      before do
        allow(group_metrics_service).to receive(:run).and_return(false)

        get url
      end

      it 'returns http error' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns response errors' do
        expect(json_response['errors']).to eq({})
      end
    end
  end
end
