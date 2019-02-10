class User < ApplicationRecord
  belongs_to :person, optional: true

  def self.from_omniauth(authentication_data)
    User.where(provider: authentication_data['provider'],uid: authentication_data['uid']).first_or_create do |user|
      person = user.build_person

      person.full_name  = authentication_data.info.name
      user.nickname     = authentication_data.info.nickname
      user.access_token = authentication_data.info.access_token
    end
  end
end
