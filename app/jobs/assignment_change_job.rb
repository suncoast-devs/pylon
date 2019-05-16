class AssignmentChangeJob < ApplicationJob
  queue_as :default

  def url(assignment)
    "https://github.com/#{assignment.person.github}/#{assignment.person.assignments_repo}/issues/#{assignment.issue}"
  end

  def perform(assignment:, type:)
    case type
    when "graded"
      GithubIssueInterface.comment_on_assignment(assignment)
      PylonBot.message(assignment.person, %{Your homework *#{assignment.homework.title}* was marked: *#{assignment.score_description}*\n#{url(assignment)}})
    when "updated"
      GithubIssueInterface.update(assignment)
      PylonBot.message(assignment.person, %{Your assignment *"#{assignment.homework.title}"* was updated with new content.\n#{url(assignment)}})
    when "created"
      GithubIssueInterface.create(assignment)
      PylonBot.message(assignment.person, %{You have an new assignment: *"#{assignment.homework.title}"*\n#{url(assignment)}})
    end
  end
end
