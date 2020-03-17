Octokit.client_id = ENV.fetch("GITHUB_APP_ID", Rails.application.credentials.GITHUB_APP_ID)
Octokit.client_secret = ENV.fetch("GITHUB_APP_SECRET", Rails.application.credentials.GITHUB_APP_SECRET)

# Automatically paginate through results, pulling back all the data
# for any github request.
Octokit.configure do |config|
  config.auto_paginate = true
end

# Setup caching
stack = Faraday::RackBuilder.new do |builder|
  builder.use Faraday::HttpCache, serializer: Marshal, shared_cache: false, logger: Rails.logger
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end
Octokit.middleware = stack
