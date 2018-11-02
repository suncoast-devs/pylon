class Invitation < ApplicationRecord
  belongs_to :cohort

  def accept!(name, email, github_username)
  end
end
