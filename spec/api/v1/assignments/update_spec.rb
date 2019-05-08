require 'rails_helper'

RSpec.describe "assignments#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/assignments/#{assignment.id}", payload
  end

  describe 'basic update' do
    let!(:assignment) { create(:assignment) }

    let(:payload) do
      {
        data: {
          id: assignment.id.to_s,
          type: 'assignments',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(AssignmentResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { assignment.reload.attributes }
    end
  end
end
