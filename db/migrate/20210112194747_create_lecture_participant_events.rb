class CreateLectureParticipantEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :lecture_participant_events do |t|
      t.belongs_to :lecture, null: false, foreign_key: true
      t.string :event_type
      t.string :name
      t.datetime :event_at

      t.timestamps
    end
  end
end
