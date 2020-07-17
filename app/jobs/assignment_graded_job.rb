class AssignmentGradedJob < ApplicationJob
  queue_as :default

  def url(assignment, score)
    "https://github.com/#{assignment.person.github}/#{assignment.person.assignments_repo}/issues/#{assignment.issue}"
  end

  def perform(assignment:)
    PylonBot.message(assignment.person, %{Your homework *#{assignment.homework.title}* was marked *#{assignment.score_description}* and is now considered *#{assignment.issue_state}*})
  end
end
