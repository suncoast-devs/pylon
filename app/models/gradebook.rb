class Gradebook
  attr_accessor :id
  attr_accessor :cohort_id
  attr_accessor :cohort
  attr_accessor :homeworks
  attr_accessor :student_enrollments
  attr_accessor :assignments

  def initialize(cohort)
    self.cohort = cohort
    self.homeworks = cohort.homeworks
    self.student_enrollments = cohort.student_enrollments
    self.assignments = cohort.student_enrollments.flat_map(&:assignments)
  end
end
