class YoutubeUploadJob < ApplicationJob
  queue_as :default

  def perform(url:, topic:)
    client = YouTubeIt::Client.new(dev_key: Rails.application.credentials.YOUTUBE_DEV_KEY)
    client.video_upload(url, title: topic, description: topic)
  end
end
