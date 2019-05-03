require 'rails_helper'

RSpec.describe "attendance_records#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/attendance_records/#{attendance_record.id}", params: params
  end

  describe 'basic fetch' do
    let!(:attendance_record) { create(:attendance_record) }

    it 'works' do
      expect(AttendanceRecordResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('attendance_records')
      expect(d.id).to eq(attendance_record.id)
    end
  end
end
