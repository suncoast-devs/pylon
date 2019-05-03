require 'rails_helper'

RSpec.describe "attendance_records#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/attendance_records/#{attendance_record.id}"
  end

  describe 'basic destroy' do
    let!(:attendance_record) { create(:attendance_record) }

    it 'updates the resource' do
      expect(AttendanceRecordResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { AttendanceRecord.count }.by(-1)
      expect { attendance_record.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
