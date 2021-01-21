class LectureVideo < ApplicationRecord
  belongs_to :cohort
  belongs_to :lecture

  has_one_attached :video
end
