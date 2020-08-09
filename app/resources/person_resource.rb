class PersonResource < ApplicationResource
  attribute :given_name, :string
  attribute :family_name, :string
  attribute :additional_name, :string
  attribute :honorific_prefix, :string
  attribute :honorific_suffix, :string
  attribute :nickname, :string
  attribute :github, :string
  attribute :full_name, :string
  attribute :shirt_size, :string
  attribute :dietary_note, :string
  attribute :slack_user, :string
  attribute :slack_invite_code, :string, writable: false

  many_to_many :cohorts
  has_many :attendance_records
  has_many :assignments
  has_many :student_progress_reports
  has_many :student_enrollments
  many_to_many :progress_reports

  attribute :is_admin, :boolean do
    @object.user && @object.user.is_admin
  end

  attribute :small_profile_image_url, :string do
    Rails.cache.fetch("small_profile_image_url_#{@object.id}") do
      begin
        uri = URI.parse(context.request.original_url)
        base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

        @object.profile_image.attached? ? context.rails_representation_url(@object.profile_image.variant(resize: "32x32", auto_orient: true), host: base_url) : nil
      rescue NoMethodError, Aws::S3::Errors::NotFound, Errno::ENOENT, ActiveStorage::FileNotFoundError => ex
      end
    end
  end

  attribute :profile_image_url, :string do
    Rails.cache.fetch("profile_image_url_#{@object.id}") do
      begin
        uri = URI.parse(context.request.original_url)
        base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

        @object.profile_image.attached? ? context.rails_representation_url(@object.profile_image.variant(resize: "300x300", auto_orient: true), host: base_url) : nil
      rescue NoMethodError, Aws::S3::Errors::NotFound, Errno::ENOENT, ActiveStorage::FileNotFoundError => ex
      end
    end
  end

  extra_attribute :token, :string do
    current_user.is_admin ? @object.token : nil
  end

  def base_scope
    Person.all.includes(:user).with_attached_profile_image

    #Person.where(id: current_user.person_id).includes(:user).with_attached_profile_image
  end
end
