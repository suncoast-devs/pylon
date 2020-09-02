class Person < ApplicationRecord
  has_many :student_enrollments, dependent: :destroy
  has_many :cohorts, through: :student_enrollments
  has_many :assignments
  has_many :homeworks, through: :assignments
  has_one :user
  has_many :attendance_records
  has_many :student_progress_reports
  has_many :progress_reports, through: :student_progress_reports

  has_one_attached :profile_image

  delegate :access_token, :github, :github=, :token, to: :user, prefix: false, allow_nil: true

  before_create :ensure_slack_invite_code

  def completed_assignments(cohort_id)
    assignments.where("score > 0").joins(:homework).where(homeworks: { counts_towards_completion: true, cohort_id: cohort_id })
  end

  def incomplete_assignments(cohort_id)
    assignments.where("score <= 0").joins(:homework).where(homeworks: { counts_towards_completion: true, cohort_id: cohort_id })
  end

  def needs_profile_image?
    !profile_image.attached?
  end

  def ensure_slack_invite_code
    self.slack_invite_code = SecureRandom.hex[0..5]
  end
end
