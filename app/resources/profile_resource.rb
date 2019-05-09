class ProfileResource < ApplicationResource
  self.model = Person

  attribute :given_name, :string
  attribute :family_name, :string
  attribute :additional_name, :string
  attribute :honorific_prefix, :string
  attribute :honorific_suffix, :string
  attribute :nickname, :string
  attribute :github, :string
  attribute :assignments_repo, :string
  attribute :full_name, :string
  attribute :shirt_size, :string
  attribute :dietary_note, :string
  attribute :slack_user, :string
  attribute :slack_invite_code, :string, writable: false

  attribute :is_admin, :boolean do
    @object.user.is_admin
  end

  attribute :small_profile_image_url, :string do
    uri = URI.parse(context.request.original_url)
    base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

    @object.profile_image.attached? ? context.rails_representation_url(@object.profile_image.variant(resize: "32x32", auto_orient: true).processed, host: base_url) : nil
  rescue Aws::S3::Errors::NotFound, Errno::ENOENT => ex
  end

  attribute :profile_image_url, :string do
    uri = URI.parse(context.request.original_url)
    base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

    @object.profile_image.attached? ? context.rails_representation_url(@object.profile_image.variant(resize: "300x300", auto_orient: true).processed, host: base_url) : nil
  rescue Aws::S3::Errors::NotFound, Errno::ENOENT => ex
  end

  extra_attribute :issues, :array do
    GithubIssueInterface.issues(@object)
  end
end
