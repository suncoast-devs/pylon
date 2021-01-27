class LectureVideoPlayback < ApplicationRecord
  belongs_to :person
  belongs_to :lecture_video
end
