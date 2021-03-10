class LectureVideoResource < ApplicationResource
  belongs_to :cohort

  attribute :title, :string
  attribute :presented_on, :date
  attribute :created_at, :datetime
  attribute :cohort_id, :integer

  attribute :presented_ago, :string do
    days_ago = (Date.today - @object.presented_on).to_i
    if days_ago < 2
      "Recent"
    else
      "#{days_ago} #{"day".pluralize(days_ago)} ago"
    end
  end

  attribute :video_url, :string do
    Rails.application.routes.url_helpers.rails_blob_url(@object.video, host: ENV["DEFAULT_HOST"])
  rescue ArgumentError, Module::DelegationError, URI::InvalidURIError
    ""
  end

  attribute :video_file_name, :string do
    @object.video.filename.to_s
  rescue Module::DelegationError
    ""
  end

  def base_scope
    # Let anyone view any lecture video if they know the id - YOLO
    LectureVideo.all.with_attached_video
  end
end
