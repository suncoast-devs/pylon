class User < ApplicationRecord
  belongs_to :person, dependent: :destroy

  def self.from_omniauth(authentication_data)
    User.where(provider: authentication_data['provider'],uid: authentication_data['uid']).first_or_create do |user|
      Rails.logger.debug ["authentication_data", authentication_data]
      person = user.build_person

      person.full_name  = authentication_data.info.name
      person.nickname   = authentication_data.info.nickname
      user.access_token = authentication_data.credentials.token

      authentication_data.extra.all_emails.each do |github_email|
        person.emails.build(label: "github", address: github_email.email, is_primary: github_email.primary)
      end

      begin
        picture = Down.download(authentication_data.info.image)

        person.profile_image.attach(io: picture, filename: picture.original_filename)
      rescue Down::Error => exception
        Rails.logger.info exception
      end
    end
  end
end
