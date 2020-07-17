class HomeworkAssignedJob < ApplicationJob
  queue_as :default

  def perform(homework:)
    homework.cohort.student_enrollments.assign_homework.includes(:person).each do |enrollment|
      homework.assignments.find_or_create_by(turned_in: false, person: enrollment.person) do
        PylonBot.message(enrollment.person, %{You have an new assignment: *"#{homework.title}"*})
      end
    end
  end
end
