source "https://rubygems.org"

ruby "2.5.1"

gem "rails", "~> 5.2"

gem "pg"
gem "puma"
gem "rack-cors"

gem "graphql"
gem "graphql-guard"
gem "jwt"

gem "graphiti"
gem "vandal_ui"
gem "kaminari"
gem "responders"

# Authentication
gem "omniauth", "~> 1.9"
gem "omniauth-github", "~> 1.3"

# Used to download content from the interwebs
gem "down", "~> 4.8"

# Gems to be used with activestorage
gem "image_processing", "~> 1.7"
gem "mini_magick", "~> 4.9"

group :development, :test do
  gem "awesome_print", "~> 1.8"
  gem "rufo"

  # Managing environment variables
  gem "dotenv-rails", "~> 2.6"
end

group :production do
  gem "aws-sdk-s3", require: false
end