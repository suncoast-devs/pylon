class User < ApplicationRecord
  belongs_to :person, dependent: :destroy

  delegate :profile_image, :needs_profile_image?, :attendance_records, :student_progress_reports, :assignments, :assignment_ids, :homeworks, :cohorts, to: :person, prefix: false, allow_nil: true

  def token
    JWT.encode({ sub: id }, Rails.application.secrets.secret_key_base)
  end

  def self.from_omniauth(authentication_data, params)
    invitation_code = params["invitation_code"]

    user_attributes = {
      provider: authentication_data["provider"],
      uid: authentication_data["uid"],
      github: authentication_data.info.nickname,
      access_token: authentication_data.credentials.token
    }

    Rails.logger.info "USER - from_omniauth : #{user_attributes.inspect}"

    if invitation_code
      enrollment = StudentEnrollment.find_by(invitation_code: invitation_code)

      return nil unless enrollment

      enrollment.person.user ||= User.create(user_attributes)

      # authentication_data.extra.all_emails.each do |github_email|
      #   person.emails.build(label: "github", address: github_email.email, is_primary: github_email.primary)
      # end

      enrollment.update(invitation_code: nil)

      return enrollment.person.user
    end

    if Rails.env.development?
      return User.find_or_create_by(provider: authentication_data["provider"], uid: authentication_data["uid"]) do |user|
               user.create_person(full_name: "Development User") unless user.person
               user.update(user_attributes.merge(is_admin: true))
             end
    end

    User.find_by(provider: authentication_data["provider"], uid: authentication_data["uid"]).tap do |user|
      user.update(user_attributes)
    end
  end
end
