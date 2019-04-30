require 'rails_helper'

RSpec.describe PersonResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'people',
          attributes: { }
        }
      }
    end

    let(:instance) do
      PersonResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Person.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:person) { create(:person) }

    let(:payload) do
      {
        data: {
          id: person.id.to_s,
          type: 'people',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      PersonResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { person.reload.updated_at }
      # .and change { person.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:person) { create(:person) }

    let(:instance) do
      PersonResource.find(id: person.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Person.count }.by(-1)
    end
  end
end
