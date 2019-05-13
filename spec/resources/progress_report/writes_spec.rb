require 'rails_helper'

RSpec.describe ProgressReportResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'progress_reports',
          attributes: { }
        }
      }
    end

    let(:instance) do
      ProgressReportResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { ProgressReport.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:progress_report) { create(:progress_report) }

    let(:payload) do
      {
        data: {
          id: progress_report.id.to_s,
          type: 'progress_reports',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ProgressReportResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { progress_report.reload.updated_at }
      # .and change { progress_report.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:progress_report) { create(:progress_report) }

    let(:instance) do
      ProgressReportResource.find(id: progress_report.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { ProgressReport.count }.by(-1)
    end
  end
end
