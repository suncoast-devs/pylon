class YoutubeUploadJob < ApplicationJob
  queue_as :default

  def perform(url:, topic:)
    account = Yt::Account.new(refresh_token: Rails.application.credentials.YOUTUBE_REFRESH_TOKEN)

    # Unless there is a : in the topic, return
    return unless topic.includes?(':')

    # Take the name of the playlist as what comes before the ':'
    playlist_name = topic.split(':').first

    # If we have one
    if playlist_name
      # Find the playlist with that name
      youtube_playlist = account.playlists.find { |playlist| playlist.title == playlist_name }

      # If we have a matching playlist then upload the video and associate it
      if youtube_playlist
        video = account.upload_video(url, title: topic, privacy_status: 'unlisted')
        youtube_playlist.add_video(video.id)
      end
    end
  end
end
