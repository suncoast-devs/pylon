require 'rails_helper'

RSpec.describe "cohorts#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/cohorts/#{cohort.id}", payload
  end

  describe 'basic update' do
    let!(:cohort) { create(:cohort) }

    let(:payload) do
      {
        data: {
          id: cohort.id.to_s,
          type: 'cohorts',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(CohortResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { cohort.reload.attributes }
    end
  end
end
