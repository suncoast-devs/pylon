require 'rails_helper'

RSpec.describe "cohort_dates#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/cohort_dates/#{cohort_date.id}", params: params
  end

  describe 'basic fetch' do
    let!(:cohort_date) { create(:cohort_date) }

    it 'works' do
      expect(CohortDateResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('cohort_dates')
      expect(d.id).to eq(cohort_date.id)
    end
  end
end
