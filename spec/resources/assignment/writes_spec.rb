require 'rails_helper'

RSpec.describe AssignmentResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'assignments',
          attributes: { }
        }
      }
    end

    let(:instance) do
      AssignmentResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Assignment.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:assignment) { create(:assignment) }

    let(:payload) do
      {
        data: {
          id: assignment.id.to_s,
          type: 'assignments',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      AssignmentResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { assignment.reload.updated_at }
      # .and change { assignment.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:assignment) { create(:assignment) }

    let(:instance) do
      AssignmentResource.find(id: assignment.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Assignment.count }.by(-1)
    end
  end
end
