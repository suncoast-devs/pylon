require 'rails_helper'

RSpec.describe "cohort_dates#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/cohort_dates/#{cohort_date.id}", payload
  end

  describe 'basic update' do
    let!(:cohort_date) { create(:cohort_date) }

    let(:payload) do
      {
        data: {
          id: cohort_date.id.to_s,
          type: 'cohort_dates',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(CohortDateResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { cohort_date.reload.attributes }
    end
  end
end
