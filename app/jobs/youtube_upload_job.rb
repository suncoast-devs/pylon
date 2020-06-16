class YoutubeUploadJob < ApplicationJob
  queue_as :default

  def perform(url:, topic:)
    account = Yt::Account.new refresh_token: Rails.application.credentials.YOUTUBE_REFRESH_TOKEN

    account.upload_video url, title: topic
  end
end
