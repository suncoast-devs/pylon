require 'rails_helper'

RSpec.describe "progress_reports#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/progress_reports", payload
  end

  describe 'basic create' do
    let(:params) do
      {
        # ... your attrs here
      }
    end
    let(:payload) do
      {
        data: {
          type: 'progress_reports',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(ProgressReportResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { ProgressReport.count }.by(1)
    end
  end
end
