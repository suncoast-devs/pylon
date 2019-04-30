require 'rails_helper'

RSpec.describe "cohorts#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/cohorts", payload
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
          type: 'cohorts',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(CohortResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Cohort.count }.by(1)
    end
  end
end
