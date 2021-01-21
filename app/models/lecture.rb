class Lecture < ApplicationRecord
  belongs_to :cohort

  has_many :lecture_participant_events
end
