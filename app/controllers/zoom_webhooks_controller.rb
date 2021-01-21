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
    topic = params.dig("payload", "object", "topic")

    if topic
      # Take the name of the playlist as what comes before the ':' and the title from what comes after
      _, cohort_name, lecture_title = *topic.match(/(.*?):\s+(.*)/)

      lecture_title.strip!

      cohort = Cohort.find_by(name: cohort_name)
      if cohort
        cohort.lectures.create(title: lecture_title)
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

  def handle_participant_event(event_type)
    topic = params.dig("payload", "object", "topic")
    participant = params.dig("payload", "object", "participant")

    return unless topic && participant

    # Take the name of the playlist as what comes before the ':' and the title from what comes after
    _, cohort_name, lecture_title = *topic.match(/(.*?):\s+(.*)/)

    lecture_title.strip!

    cohort = Cohort.find_by(name: cohort_name)
    if cohort
      lecture = cohort.lectures.find_by(title: lecture_title)
      if lecture
        participant_field = case event_type
                            when "joined"
                              "join_time"
                            when "left"
                              "leave_time"
                            else
                              ""
                            end

        lecture.lecture_participant_events.create(event_type: event_type, name: partipant[user_name], event_at: participant[participant_field])
      end
    end
  end
end
