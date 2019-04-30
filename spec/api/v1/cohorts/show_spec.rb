require 'rails_helper'

RSpec.describe "cohorts#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/cohorts/#{cohort.id}", params: params
  end

  describe 'basic fetch' do
    let!(:cohort) { create(:cohort) }

    it 'works' do
      expect(CohortResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('cohorts')
      expect(d.id).to eq(cohort.id)
    end
  end
end
