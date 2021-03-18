class Homework < ApplicationRecord
  belongs_to :cohort
  counter_culture :cohort,
                  column_names: {
                    ["homeworks.assignments_count > 0 AND counts_towards_completion = true "] => "assigned_homework_marked_for_completion_count"
                  },
                  column_name: proc { |homework| homework.assignments_count && homework.assignments_count > 0 && homework.counts_towards_completion? ? "assigned_homework_marked_for_completion_count" : nil }

  has_many :assignments

  # Virtual attribute to use to re-assign an assignment
  attr_accessor :reassigned

  def title
    "#{name} - #{summary}"
  end
end
