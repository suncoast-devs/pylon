class Assignment < ApplicationRecord
  NOT_GRADED = -1
  UNACCEPTABLE = 0
  NEEDS_IMPROVEMENT = 1
  ACCEPTABLE = 2
  MEETS_EXPECTATION = 3
  EXCEEDS_EXPECTATION = 4

  scope :recompute_completed_assignments_count, -> { where("score > ?", UNACCEPTABLE).joins(:homework).where(homeworks: { counts_towards_completion: true }) }

  belongs_to :homework, counter_cache: true
  belongs_to :person
  belongs_to :student_enrollment
  counter_culture :student_enrollment,
                  column_names: {
                    Assignment.recompute_completed_assignments_count => "completed_assignments_count"
                  },
                  column_name: proc { |assignment| assignment.score > UNACCEPTABLE && assignment.homework.counts_towards_completion? ? "completed_assignments_count" : nil }

  has_many :assignment_events

  def issue_state
    case score
    when NOT_GRADED
      "open"
    when UNACCEPTABLE
      "open"
    when NEEDS_IMPROVEMENT
      "open"
    when ACCEPTABLE
      "closed"
    when MEETS_EXPECTATION
      "closed"
    when EXCEEDS_EXPECTATION
      "closed"
    end
  end

  def score_description
    case score
    when NOT_GRADED
      "Not Graded"
    when UNACCEPTABLE
      "Unacceptable"
    when NEEDS_IMPROVEMENT
      "Needs Improvement"
    when ACCEPTABLE
      "Acceptable"
    when MEETS_EXPECTATION
      "Meets Expectations"
    when EXCEEDS_EXPECTATION
      "Exceeds Expectations"
    end
  end
end
