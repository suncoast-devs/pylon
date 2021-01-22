class AddLectureToLectureVideos < ActiveRecord::Migration[6.0]
  def change
    add_reference :lecture_videos, :lecture, null: true, foreign_key: true
  end
end
