require 'rails_helper'

RSpec.describe "progress_reports#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/progress_reports/#{progress_report.id}", params: params
  end

  describe 'basic fetch' do
    let!(:progress_report) { create(:progress_report) }

    it 'works' do
      expect(ProgressReportResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('progress_reports')
      expect(d.id).to eq(progress_report.id)
    end
  end
end
