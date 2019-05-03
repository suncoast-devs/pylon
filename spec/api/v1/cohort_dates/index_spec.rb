require 'rails_helper'

RSpec.describe "cohort_dates#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/cohort_dates", params: params
  end

  describe 'basic fetch' do
    let!(:cohort_date1) { create(:cohort_date) }
    let!(:cohort_date2) { create(:cohort_date) }

    it 'works' do
      expect(CohortDateResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['cohort_dates'])
      expect(d.map(&:id)).to match_array([cohort_date1.id, cohort_date2.id])
    end
  end
end
