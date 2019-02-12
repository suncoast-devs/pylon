Rails.application.config.middleware.use OmniAuth::Builder do
  app_id = ENV.fetch('GITHUB_APP_ID', Rails.application.credentials.GITHUB_APP_ID)
  app_secret = ENV.fetch('GITHUB_APP_SECRET', Rails.application.credentials.GITHUB_APP_SECRET)
  provider :github, app_id, app_secret, scope: "user,repo,gist"
end
