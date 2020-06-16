Yt.configure do |config|
  config.client_id = Rails.application.credentials.YOUTUBE_CLIENT_ID
  config.client_secret = Rails.application.credentials.YOUTUBE_CLIENT_SECRET
end
