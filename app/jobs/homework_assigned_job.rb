class HomeworkAssignedJob < ApplicationJob
  queue_as :default

  def perform(homework:)
    homework.cohort.student_enrollments.can_be_assigned_homework.includes(:person).each do |enrollment|
      homework.assignments.find_or_create_by(person: enrollment.person) do |assignment|
        PylonBot.message(enrollment.person, %{You have a new assignment: *"#{homework.title}"*: #{NEXUS_BASE_URL}/assignments/#{assignment.id} })
      end
    end
  end
end
