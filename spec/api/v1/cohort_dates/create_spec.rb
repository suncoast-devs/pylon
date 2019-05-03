require 'rails_helper'

RSpec.describe "cohort_dates#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/cohort_dates", payload
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
          type: 'cohort_dates',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(CohortDateResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { CohortDate.count }.by(1)
    end
  end
end
