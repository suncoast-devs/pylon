class LectureVideoResource < ApplicationResource
  belongs_to :cohort

  attribute :title, :string
  attribute :cohort_id, :integer

  attribute :video_url, :string do
    @object.video.service_url
  rescue Module::DelegationError
    ""
  end

  def base_scope
    return LectureVideo.all if admin?

    LectureVideo.where(cohort_id: current_user.cohorts.pluck(:id))
  end
end
