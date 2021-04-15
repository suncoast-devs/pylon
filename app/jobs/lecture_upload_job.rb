class LectureUploadJob < ApplicationJob
  queue_as :default

  # If we have a download error apply some retry logic
  retry_on(Down::ClientError, wait: 60.seconds, attempts: 5) do |job, error|
    Raven.capture_exception(exception)
  end

  def perform(url:, topic:)
    if ENV["BLOCK_LECTURE_UPLOAD_JOB"]
      Rails.logger.info "LectureUploadJob are currently blocked"
      return
    end

    cohort_name, video_title = Lecture.split_zoom_topic(topic)

    unless cohort_name && video_title
      Rails.logger.info "Did not upload a video, URL and topic redacted"
      return
    end

    cohort = Cohort.find_by(name: cohort_name)
    unless cohort
      Rails.logger.info "Did not upload a video as the topic did not match any cohort name"

      return
    end

    LectureVideo.transaction do
      Rails.logger.info %{Uploading from "#{url}"}

      lecture = cohort.lectures.find_by(title: video_title)

      # Create the lecture video
      lecture_video = cohort.lecture_videos.create(lecture: lecture, title: video_title, presented_on: Date.today)

      if lecture_video.valid?
        # Attach the video
        lecture_video.video.attach(
          io: Down.open(url),
          filename: "lectures/#{cohort.name.parameterize}/#{video_title.parameterize}.mp4",
          content_type: "video/mp4"
        )

        begin
          PylonBot.channel_message(channel: cohort.slack_channel_name, text: "New video posted to cohort playlist: #{video_title}")
        rescue StandardError => exception
          # Rescue any error from the pylon bot so the transaction doesn't fail, but do report it
          Raven.capture_exception(exception)
        end
      else
        Rails.logger.info "Unable to create lecture video: #{lecture_video.errors.full_messages.to_sentence}"
      end
    end
  end
end
