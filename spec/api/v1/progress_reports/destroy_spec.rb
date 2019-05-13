require 'rails_helper'

RSpec.describe "progress_reports#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/progress_reports/#{progress_report.id}"
  end

  describe 'basic destroy' do
    let!(:progress_report) { create(:progress_report) }

    it 'updates the resource' do
      expect(ProgressReportResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { ProgressReport.count }.by(-1)
      expect { progress_report.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
