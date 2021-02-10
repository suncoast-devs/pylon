class HomeworkAssignedJob < ApplicationJob
  queue_as :default

  NEXUS_BASE_URL = ENV["NEXUS_BASE_URL"]

  def perform(homework:)
    enrollments = homework.cohort.student_enrollments.can_be_assigned_homework.includes(:person)

    enrollments.each do |enrollment|
      # TODO: Use previously_new_record? when we update to Rails 6.1
      homework.assignments.find_or_initialize_by(person: enrollment.person) do |assignment|
        assignment.save
        PylonBot.message(enrollment.person, %{You have a new assignment: *"#{homework.title}"*: #{NEXUS_BASE_URL}/assignment/#{assignment.id}})
      end
    end
  end
end
