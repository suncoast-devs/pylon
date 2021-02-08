class StudentEnrollment < ApplicationRecord
  belongs_to :cohort
  belongs_to :person

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

  def completed_homework_count
    @completed_homework_count ||= person.completed_assignments(cohort).count
  end

  def counted_homework
    @counted_homework ||= cohort.assigned_homework_marked_for_completion.count
  end

  def completion_percentage
    @completion_percentage ||= begin
      counted_homework > 0 ? (completed_homework_count * 100.0) / counted_homework : 0.0
    end
  end

  def needed_to_complete_count
    counted_homework == 0 ? nil : ([0, (80 - completion_percentage) / 100.0].max * counted_homework).ceil
  end
end
