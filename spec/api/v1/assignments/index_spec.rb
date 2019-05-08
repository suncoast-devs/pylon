require 'rails_helper'

RSpec.describe "assignments#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/assignments", params: params
  end

  describe 'basic fetch' do
    let!(:assignment1) { create(:assignment) }
    let!(:assignment2) { create(:assignment) }

    it 'works' do
      expect(AssignmentResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['assignments'])
      expect(d.map(&:id)).to match_array([assignment1.id, assignment2.id])
    end
  end
end
