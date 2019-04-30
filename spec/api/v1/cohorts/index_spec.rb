require 'rails_helper'

RSpec.describe "cohorts#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/cohorts", params: params
  end

  describe 'basic fetch' do
    let!(:cohort1) { create(:cohort) }
    let!(:cohort2) { create(:cohort) }

    it 'works' do
      expect(CohortResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['cohorts'])
      expect(d.map(&:id)).to match_array([cohort1.id, cohort2.id])
    end
  end
end
