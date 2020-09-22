class AssignmentGradedJob < ApplicationJob
  queue_as :default

  def perform(person:, homework_title:, marked:, issue_state:)
    PylonBot.message(person, %{Your homework *#{homework_title}* was marked *#{marked}* and is now considered *#{issue_state}*\You received the following comment:\n#{comment}})
  end
end
