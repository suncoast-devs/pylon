require 'rails_helper'

RSpec.describe "attendance_records#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/attendance_records", payload
  end

  describe 'basic create' do
    let(:params) do
      {
        # ... your attrs here
      }
    end
    let(:payload) do
      {
        data: {
          type: 'attendance_records',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(AttendanceRecordResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { AttendanceRecord.count }.by(1)
    end
  end
end
