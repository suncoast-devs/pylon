class YoutubeUploadJob < ApplicationJob
  queue_as :default

  def perform(url:, topic:)
    account = Yt::Account.new(refresh_token: Rails.application.credentials.YOUTUBE_REFRESH_TOKEN)

    # Unless there is a : in the topic, return
    unless topic.include?(':')
      Rails.logger.info "Did not upload a video to YouTube, URL and topic redacted -- no playlist included"
      return
    end

    # Take the name of the playlist as what comes before the ':' and the title from what comes after
    playlist_name, video_title = topic.split(':')

    # If we have one
    if playlist_name
      # Find the playlist with that name
      youtube_playlist = account.playlists.find { |playlist| playlist.title == playlist_name }

      # If we have a matching playlist then upload the video and associate it
      if youtube_playlist
        video = account.upload_video(url, title: video_title, privacy_status: 'unlisted')
        youtube_playlist.add_video(video.id, { position: 0 })

        PylonBot.channel_message(channel: playlist_name, text: "New video posted to youtube playlist: #{video_title}")
      end
    else
      Rails.logger.info "Did not upload a video to YouTube, URL and topic redacted -- playlist not found"
    end
  end
end
