class DownloadProfileImageJob < ApplicationJob
  queue_as :default

  def perform(user: nil, person: nil, url:)
    person = person || user.person

    picture = Down.download(url)

    person.profile_image.attach(io: picture, filename: picture.original_filename)

    # Process variants
    person.profile_image.variant(resize: "32x32", auto_orient: true).processed
    person.profile_image.variant(resize: "300x300", auto_orient: true).processed
  rescue Down::Error => exception
    Rails.logger.info exception
  end
end
