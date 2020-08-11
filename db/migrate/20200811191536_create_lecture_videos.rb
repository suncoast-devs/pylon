class CreateLectureVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :lecture_videos do |t|
      t.string :title
      t.date :presented_on
      t.belongs_to :cohort, null: false, foreign_key: true

      t.timestamps
    end
  end
end
