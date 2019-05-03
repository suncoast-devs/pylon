require 'rails_helper'

RSpec.describe AttendanceRecordResource, type: :resource do
  describe 'serialization' do
    let!(:attendance_record) { create(:attendance_record) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(attendance_record.id)
      expect(data.jsonapi_type).to eq('attendance_records')
    end
  end

  describe 'filtering' do
    let!(:attendance_record1) { create(:attendance_record) }
    let!(:attendance_record2) { create(:attendance_record) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: attendance_record2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([attendance_record2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:attendance_record1) { create(:attendance_record) }
      let!(:attendance_record2) { create(:attendance_record) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            attendance_record1.id,
            attendance_record2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            attendance_record2.id,
            attendance_record1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
