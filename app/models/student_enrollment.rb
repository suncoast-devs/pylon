class StudentEnrollment < ApplicationRecord
  belongs_to :cohort
  belongs_to :person

  before_create :ensure_invitation_code

  def ensure_invitation_code
    self.invitation_code = SecureRandom.hex[0..6]
  end
end
