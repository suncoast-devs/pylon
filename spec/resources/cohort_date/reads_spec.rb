require 'rails_helper'

RSpec.describe CohortDateResource, type: :resource do
  describe 'serialization' do
    let!(:cohort_date) { create(:cohort_date) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(cohort_date.id)
      expect(data.jsonapi_type).to eq('cohort_dates')
    end
  end

  describe 'filtering' do
    let!(:cohort_date1) { create(:cohort_date) }
    let!(:cohort_date2) { create(:cohort_date) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: cohort_date2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([cohort_date2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:cohort_date1) { create(:cohort_date) }
      let!(:cohort_date2) { create(:cohort_date) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            cohort_date1.id,
            cohort_date2.id
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
            cohort_date2.id,
            cohort_date1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
