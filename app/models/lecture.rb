class Lecture < ApplicationRecord
  belongs_to :cohort

  has_many :lecture_participant_events

  def self.split_zoom_topic(topic)
    _, cohort_name, lecture_title = *topic.match(/(.*?)[:-]\s+(.*)/)

    cohort_name.strip! if cohort_name
    lecture_title.strip! if lecture_title

    return [cohort_name, lecture_title]
  end
end
