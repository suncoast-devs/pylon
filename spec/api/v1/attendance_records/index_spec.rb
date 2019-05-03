require 'rails_helper'

RSpec.describe "attendance_records#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/attendance_records", params: params
  end

  describe 'basic fetch' do
    let!(:attendance_record1) { create(:attendance_record) }
    let!(:attendance_record2) { create(:attendance_record) }

    it 'works' do
      expect(AttendanceRecordResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['attendance_records'])
      expect(d.map(&:id)).to match_array([attendance_record1.id, attendance_record2.id])
    end
  end
end
