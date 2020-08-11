class RecordingsController < ApplicationController
  def create
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
  end
end
