require 'rails_helper'

RSpec.describe CohortDateResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'cohort_dates',
          attributes: { }
        }
      }
    end

    let(:instance) do
      CohortDateResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { CohortDate.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:cohort_date) { create(:cohort_date) }

    let(:payload) do
      {
        data: {
          id: cohort_date.id.to_s,
          type: 'cohort_dates',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      CohortDateResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { cohort_date.reload.updated_at }
      # .and change { cohort_date.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:cohort_date) { create(:cohort_date) }

    let(:instance) do
      CohortDateResource.find(id: cohort_date.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { CohortDate.count }.by(-1)
    end
  end
end
