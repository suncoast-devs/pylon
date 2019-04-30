require 'rails_helper'

RSpec.describe "people#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/people/#{person.id}", params: params
  end

  describe 'basic fetch' do
    let!(:person) { create(:person) }

    it 'works' do
      expect(PersonResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('people')
      expect(d.id).to eq(person.id)
    end
  end
end
