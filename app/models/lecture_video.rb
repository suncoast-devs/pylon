class LectureVideo < ApplicationRecord
  belongs_to :cohort
  belongs_to :lecture, required: false
  has_many :lecture_video_playbacks, dependent: :destroy

  has_one_attached :video
end
