class User < ApplicationRecord
  belongs_to :person, optional: true

  def self.from_auth_hash(auth_hash)
    User.find_or_create_by(auth_sub: auth_hash["sub"])
  end
end
