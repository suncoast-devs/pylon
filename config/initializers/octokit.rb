Octokit.client_id = ENV.fetch('GITHUB_APP_ID', Rails.application.credentials.GITHUB_APP_ID)
Octokit.client_secret = ENV.fetch('GITHUB_APP_SECRET', Rails.application.credentials.GITHUB_APP_SECRET)
