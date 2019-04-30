require 'rails_helper'

RSpec.describe "people#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/people/#{person.id}", payload
  end

  describe 'basic update' do
    let!(:person) { create(:person) }

    let(:payload) do
      {
        data: {
          id: person.id.to_s,
          type: 'people',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(PersonResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { person.reload.attributes }
    end
  end
end
