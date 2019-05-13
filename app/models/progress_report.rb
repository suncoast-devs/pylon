class ProgressReport < ApplicationRecord
  belongs_to :cohort
  has_many :student_progress_reports

  def self.completed
    where(completed: true)
  end

  attr_accessor :people
  attr_accessor :homeworks
end
