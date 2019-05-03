require 'rails_helper'

RSpec.describe AttendanceRecordResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'attendance_records',
          attributes: { }
        }
      }
    end

    let(:instance) do
      AttendanceRecordResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { AttendanceRecord.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:attendance_record) { create(:attendance_record) }

    let(:payload) do
      {
        data: {
          id: attendance_record.id.to_s,
          type: 'attendance_records',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      AttendanceRecordResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { attendance_record.reload.updated_at }
      # .and change { attendance_record.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:attendance_record) { create(:attendance_record) }

    let(:instance) do
      AttendanceRecordResource.find(id: attendance_record.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { AttendanceRecord.count }.by(-1)
    end
  end
end
