require 'rails_helper'

RSpec.describe "cohort_dates#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/cohort_dates/#{cohort_date.id}"
  end

  describe 'basic destroy' do
    let!(:cohort_date) { create(:cohort_date) }

    it 'updates the resource' do
      expect(CohortDateResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { CohortDate.count }.by(-1)
      expect { cohort_date.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
