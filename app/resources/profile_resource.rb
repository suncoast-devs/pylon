class ProfileResource < ApplicationResource
  self.model = Person
  
  attribute :given_name, :string
  attribute :family_name, :string
  attribute :additional_name, :string
  attribute :honorific_prefix, :string
  attribute :honorific_suffix, :string
  attribute :nickname, :string
  attribute :full_name, :string
  attribute :shirt_size, :string
  attribute :dietary_note, :string

  attribute :is_admin, :boolean do
    @object.user.is_admin
  end

  attribute :small_profile_image_url, :string do
    uri = URI.parse(context.request.original_url)
    base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

    context.rails_representation_url(@object.profile_image.variant(resize: "32x32", auto_orient: true).processed, host: base_url)
  rescue Aws::S3::Errors::NotFound, Errno::ENOENT => ex
  end

  attribute :profile_image_url, :string do
    uri = URI.parse(context.request.original_url)
    base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

    context.rails_representation_url(@object.profile_image.variant(resize: "300x300", auto_orient: true).processed, host: base_url)
  rescue Aws::S3::Errors::NotFound, Errno::ENOENT => ex
  end
end
