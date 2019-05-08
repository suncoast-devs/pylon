class Assignment < ApplicationRecord
  belongs_to :homework
  belongs_to :person

  def score_description
    case score
    when 0
      'Unacceptable'
    when 1
      'Needs Improvement'
    when 2
      'Acceptable'
    when 3
      'Meets Expectations'
    when 4
      'Exceeds Expectations'
    end
  end
end
