class DownloadProfileImageJob < ApplicationJob
  queue_as :default

  def perform(user: nil, person: nil, url:)
    person = person || user.person

    picture = Down.download(url)

    person.profile_image.attach(io: picture, filename: picture.original_filename)
  rescue Down::Error => exception
    Rails.logger.info exception
  end
end
