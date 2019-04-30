require 'rails_helper'

RSpec.describe "people#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/people/#{person.id}"
  end

  describe 'basic destroy' do
    let!(:person) { create(:person) }

    it 'updates the resource' do
      expect(PersonResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Person.count }.by(-1)
      expect { person.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
