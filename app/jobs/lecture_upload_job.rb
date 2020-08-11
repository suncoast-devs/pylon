class LectureUploadJob < ApplicationJob
  queue_as :default

  def perform(url:, topic:)
    # Unless there is a : in the topic, return
    unless topic.include?(":")
      Rails.logger.info "Did not upload a video, URL and topic redacted"
      return
    end

    # Take the name of the playlist as what comes before the ':' and the title from what comes after
    cohort_name, video_title = topic.split(":")

    cohort = Cohort.all.find { |cohort| cohort_name.parameterize.start_with?(cohort.name.parameterize) }
    unless cohort
      Rails.logger.info "Did not upload a video as the topic did not match any cohort name"

      return
    end

    # Create the lecture video
    lecture_video = cohort.lecture_videos.create(title: video_title, presented_on: Date.today)

    # Attach the video
    lecture_video.video.attach(
      io: open(url),
      filename: "lectures/#{cohort.name.parameterize}/#{video_title.parameterize}.mp4",
      content_type: "video/mp4"
    )

    PylonBot.channel_message(channel: cohort.slack_channel_name, text: "New video posted to cohort playlist: #{video_title}")
  end
end
