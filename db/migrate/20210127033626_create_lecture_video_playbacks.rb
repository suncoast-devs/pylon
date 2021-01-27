class CreateLectureVideoPlaybacks < ActiveRecord::Migration[6.0]
  def change
    create_table :lecture_video_playbacks do |t|
      t.belongs_to :lecture_video
      t.belongs_to :person

      t.timestamps
    end
  end
end
