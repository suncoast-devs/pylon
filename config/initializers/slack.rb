# Slackbot requires this ENV token
ENV["SLACK_API_TOKEN"] = Rails.application.credentials.SLACK_API_TOKEN

# We also use the slack-ruby-client directly (for sending messages)
Slack.configure do |config|
  config.token = ENV["SLACK_API_TOKEN"]
end
