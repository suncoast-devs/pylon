require 'rails_helper'

RSpec.describe ProgressReportResource, type: :resource do
  describe 'serialization' do
    let!(:progress_report) { create(:progress_report) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(progress_report.id)
      expect(data.jsonapi_type).to eq('progress_reports')
    end
  end

  describe 'filtering' do
    let!(:progress_report1) { create(:progress_report) }
    let!(:progress_report2) { create(:progress_report) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: progress_report2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([progress_report2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:progress_report1) { create(:progress_report) }
      let!(:progress_report2) { create(:progress_report) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            progress_report1.id,
            progress_report2.id
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
            progress_report2.id,
            progress_report1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
