require 'rails_helper'

RSpec.describe "attendance_records#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/attendance_records/#{attendance_record.id}", payload
  end

  describe 'basic update' do
    let!(:attendance_record) { create(:attendance_record) }

    let(:payload) do
      {
        data: {
          id: attendance_record.id.to_s,
          type: 'attendance_records',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(AttendanceRecordResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { attendance_record.reload.attributes }
    end
  end
end
