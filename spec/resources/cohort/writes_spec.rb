require 'rails_helper'

RSpec.describe CohortResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'cohorts',
          attributes: { }
        }
      }
    end

    let(:instance) do
      CohortResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Cohort.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:cohort) { create(:cohort) }

    let(:payload) do
      {
        data: {
          id: cohort.id.to_s,
          type: 'cohorts',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      CohortResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { cohort.reload.updated_at }
      # .and change { cohort.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:cohort) { create(:cohort) }

    let(:instance) do
      CohortResource.find(id: cohort.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Cohort.count }.by(-1)
    end
  end
end
