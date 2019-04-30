require 'rails_helper'

RSpec.describe CohortResource, type: :resource do
  describe 'serialization' do
    let!(:cohort) { create(:cohort) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(cohort.id)
      expect(data.jsonapi_type).to eq('cohorts')
    end
  end

  describe 'filtering' do
    let!(:cohort1) { create(:cohort) }
    let!(:cohort2) { create(:cohort) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: cohort2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([cohort2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:cohort1) { create(:cohort) }
      let!(:cohort2) { create(:cohort) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            cohort1.id,
            cohort2.id
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
            cohort2.id,
            cohort1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
