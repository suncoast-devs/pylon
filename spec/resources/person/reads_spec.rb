require 'rails_helper'

RSpec.describe PersonResource, type: :resource do
  describe 'serialization' do
    let!(:person) { create(:person) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(person.id)
      expect(data.jsonapi_type).to eq('people')
    end
  end

  describe 'filtering' do
    let!(:person1) { create(:person) }
    let!(:person2) { create(:person) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: person2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([person2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:person1) { create(:person) }
      let!(:person2) { create(:person) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            person1.id,
            person2.id
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
            person2.id,
            person1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
