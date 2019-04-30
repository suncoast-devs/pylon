require 'rails_helper'

RSpec.describe "cohorts#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/cohorts/#{cohort.id}"
  end

  describe 'basic destroy' do
    let!(:cohort) { create(:cohort) }

    it 'updates the resource' do
      expect(CohortResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Cohort.count }.by(-1)
      expect { cohort.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
