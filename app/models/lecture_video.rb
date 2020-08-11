class LectureVideo < ApplicationRecord
  belongs_to :cohort

  has_one_attached :video
end
