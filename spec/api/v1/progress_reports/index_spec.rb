require 'rails_helper'

RSpec.describe "progress_reports#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/progress_reports", params: params
  end

  describe 'basic fetch' do
    let!(:progress_report1) { create(:progress_report) }
    let!(:progress_report2) { create(:progress_report) }

    it 'works' do
      expect(ProgressReportResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['progress_reports'])
      expect(d.map(&:id)).to match_array([progress_report1.id, progress_report2.id])
    end
  end
end
