class AssignmentGradedJob < ApplicationJob
  queue_as :default

  def perform(assignment:)
    PylonBot.message(assignment.person, %{Your homework *#{assignment.homework.title}* was marked *#{assignment.score_description}* and is now considered *#{assignment.issue_state}*})
  end
end
