namespace :bot do
  desc "Slack Bot"
  task run: :environment do
    PylonBot.run
  end
end
