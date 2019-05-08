require 'rails_helper'

RSpec.describe "assignments#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/assignments/#{assignment.id}"
  end

  describe 'basic destroy' do
    let!(:assignment) { create(:assignment) }

    it 'updates the resource' do
      expect(AssignmentResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Assignment.count }.by(-1)
      expect { assignment.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
