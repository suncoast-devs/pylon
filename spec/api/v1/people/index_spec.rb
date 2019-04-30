require 'rails_helper'

RSpec.describe "people#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/people", params: params
  end

  describe 'basic fetch' do
    let!(:person1) { create(:person) }
    let!(:person2) { create(:person) }

    it 'works' do
      expect(PersonResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['people'])
      expect(d.map(&:id)).to match_array([person1.id, person2.id])
    end
  end
end
