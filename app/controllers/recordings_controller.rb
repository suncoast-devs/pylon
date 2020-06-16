class RecordingsController < ApplicationController
  def create
    topic = params["payload"]["topic"]

    download_url = URI(params["payload"]["download_url"])
    dowload_url.query = "access_token=#{token}"

    YoutubeUploadJob.perform_later(url: download_url.to_s, topic: topic)
  end
end
