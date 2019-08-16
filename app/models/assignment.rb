class Assignment < ApplicationRecord
  belongs_to :homework, counter_cache: true
  belongs_to :person

  UNACCEPTABLE = 0
  NEEDS_IMPROVEMENT = 1
  ACCEPTABLE = 2
  MEETS_EXPECTATION = 3
  EXCEEDS_EXPECTATION = 4

  def issue_state
    case score
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
