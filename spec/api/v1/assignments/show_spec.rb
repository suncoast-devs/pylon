require 'rails_helper'

RSpec.describe "assignments#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/assignments/#{assignment.id}", params: params
  end

  describe 'basic fetch' do
    let!(:assignment) { create(:assignment) }

    it 'works' do
      expect(AssignmentResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('assignments')
      expect(d.id).to eq(assignment.id)
    end
  end
end
