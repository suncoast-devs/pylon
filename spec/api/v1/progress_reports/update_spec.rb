require 'rails_helper'

RSpec.describe "progress_reports#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/progress_reports/#{progress_report.id}", payload
  end

  describe 'basic update' do
    let!(:progress_report) { create(:progress_report) }

    let(:payload) do
      {
        data: {
          id: progress_report.id.to_s,
          type: 'progress_reports',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ProgressReportResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { progress_report.reload.attributes }
    end
  end
end
