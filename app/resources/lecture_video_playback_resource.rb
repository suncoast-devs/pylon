class LectureVideoPlaybackResource < ApplicationResource
  belongs_to :person
  belongs_to :lecture_video

  attribute :person_id, :integer, writable: false
  attribute :lecture_video_id, :integer

  before_save :ensure_person_id

  def ensure_person_id(object)
    object.person_id = current_person.id
  end
end
