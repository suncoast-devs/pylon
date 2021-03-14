class StudentEnrollment < ApplicationRecord
  belongs_to :cohort
  belongs_to :person

  has_many :assignments

  before_create :ensure_invitation_code

  def self.can_be_assigned_homework
    where(active: true)
  end

  def can_be_assigned_homework
    active
  end

  def show_grade
    active && !auditing
  end

  def generate_progress_report
    active && !auditing
  end

  def ensure_invitation_code
    self.invitation_code = SecureRandom.hex[0..6]
  end

  def needed_to_complete_count
    counted_homework == 0 ? nil : ([0, (80 - completion_percentage) / 100.0].max * counted_homework).ceil
  end

  def completion_percentage
    @completion_percentage ||= begin
      counted_homework > 0 ? (completed_assignments_count * 100.0) / counted_homework : 0.0
    end
  end

  private

  def counted_homework
    @counted_homework ||= (cohort.assigned_homework_marked_for_completion_count || 0)
  end
end
