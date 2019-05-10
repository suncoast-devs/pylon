class User < ApplicationRecord
  belongs_to :person, dependent: :destroy

  delegate :profile_image, :needs_profile_image?, :attendance_records, :assignments, :homeworks, :cohorts, to: :person, prefix: false

  def self.from_omniauth(authentication_data, params)
    invitation_code = params["invitation_code"]

    if invitation_code
      enrollment = StudentEnrollment.find_by(invitation_code: invitation_code)

      return nil unless enrollment

      enrollment.person.user ||= User.create(provider: authentication_data["provider"],
                                             uid: authentication_data["uid"],
                                             github: authentication_data.info.nickname,
                                             access_token: authentication_data.credentials.token)

      # authentication_data.extra.all_emails.each do |github_email|
      #   person.emails.build(label: "github", address: github_email.email, is_primary: github_email.primary)
      # end

      enrollment.update(invitation_code: nil)

      enrollment.person.user
    else
      User.find_by(provider: authentication_data["provider"], uid: authentication_data["uid"])
    end
  end
end
