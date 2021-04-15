class ZoomWebhooksController < ApplicationController
  #   {
  #     "event": "string",
  #     "event_ts": "long",
  #     "payload": {
  #         "account_id": "string",
  #         "operator": "email(string)",
  #         "object": {
  #             "id": "integer",//int64 or long data type
  #             "uuid": "string",
  #             "host_id": "string",
  #             "topic": "string",
  #             "type": "integer",
  #             "start_time": "string [date-time]",
  #             "timezone": "string",
  #             "duration": "integer",
  #             "occurrences": [  // returned only if meeting type is 8
  #                 {
  #                     "occurrence_id": "integer",
  #                     "start_time": "string [date-time]"
  #                 }
  #             ]
  #         }
  #     }
  # }
  def new_meeting
    # Attempt to create this lecture if needed
    lecture = find_or_create_lecture(params)

    # Announce the lecture if one can be found
    if lecture
      begin
        PylonBot.channel_message(channel: lecture.cohort.slack_channel_name, text: "New lecture started: #{lecture.title}")
      rescue StandardError => exception
        # Rescue any error from the pylon bot so the transaction doesn't fail, but do report it
        Raven.capture_exception(exception)
      end
    end

    head :ok
  end

  # {
  #   "event": "string",
  #   "event_ts": "long",
  #   "payload": {
  #     "account_id": "string",
  #     "object": {
  #       "id": "string",
  #       "uuid": "string",
  #       "host_id": "string",
  #       "topic": "string",
  #       "type": "integer",
  #       "start_time": "string [date-time]",
  #       "timezone": "string",
  #       "duration": "integer",
  #       "participant": {
  #         "user_id": "string",
  #         "user_name": "string",
  #         "email": "string",
  #         "id": "string",
  #         "join_time": "string [date-time]"
  #       }
  #     }
  #   }
  # }
  def participant_joined_meeting
    handle_participant_event("joined")

    head :ok
  end

  # {
  #   "event": "string",
  #   "event_ts": "long",
  #   "payload": {
  #     "account_id": "string",
  #     "object": {
  #       "id": "string",
  #       "uuid": "string",
  #       "host_id": "string",
  #       "topic": "string",
  #       "type": "integer",
  #       "start_time": "string [date-time]",
  #       "timezone": "string",
  #       "duration": "integer",
  #       "participant": {
  #         "user_id": "string",
  #         "email": "string",
  #         "user_name": "string",
  #         "id": "string",
  #         "leave_time": "string [date-time]"
  #       }
  #     }
  #   }
  # }
  def participant_left_meeting
    handle_participant_event("left")

    head :ok
  end

  def new_recording
    find_or_create_lecture(params)

    token = params["download_token"]

    payload = params["payload"]
    return unless payload

    object = payload["object"]
    return unless object

    recording = object["recording_files"].find { |recording| recording["recording_type"] == "shared_screen_with_speaker_view" }
    return unless recording

    uri = recording["download_url"]
    download_url = URI(uri)
    download_url.query = "access_token=#{token}"

    topic = object["topic"]

    LectureUploadJob.perform_later(url: download_url.to_s, topic: topic)

    head :ok
  end

  private

  def find_or_create_lecture(params)
    topic = params.dig("payload", "object", "topic")

    return nil unless topic

    # Take the name of the playlist as what comes before the ':' or '-' and the title from what comes after
    cohort_name, lecture_title = Lecture.split_zoom_topic(topic)

    return nil unless lecture_title

    cohort = Cohort.find_by(name: cohort_name)

    return unless cohort

    cohort.lectures.find_or_create_by(title: lecture_title)
  end

  def handle_participant_event(event_type)
    lecture = find_or_create_lecture(params)

    return unless lecture

    participant = params.dig("payload", "object", "participant")

    return unless participant

    participant_field = case event_type
                        when "joined"
                          "join_time"
                        when "left"
                          "leave_time"
                        else
                          ""
                        end

    lecture.lecture_participant_events.create(event_type: event_type, name: participant[:user_name], event_at: participant[participant_field])
  end
end
