module Types
  class Person < Types::BaseObject
    include ::AutoDescription
    include Rails.application.routes.url_helpers

    description "A person"

    field :id, ID, null: false
    field :given_name, String, null: true
    field :family_name, String, null: true
    field :full_name, String, null: false

    field :links, [Types::Link], null: true

    field :profile, Types::StudentProfile, null: true
    field :programs, [Types::Program], null: true
    field :cohorts, [Types::Cohort], null: true
    
    field :profile_image_url, String, "300x300 px profile image", null: true
    field :small_profile_image_url, String, "32x32 px profile image", null: true

    field :is_admin, Boolean, "True if this person's account is an admin", null: false

    def is_admin
      object.user.is_admin
    end
    
    def small_profile_image_url
      rails_representation_url(object.profile_image.variant(resize: "32x32", auto_orient: true).processed, host: context[:base_url])
    end

    def profile_image_url
      rails_representation_url(object.profile_image.variant(resize: "300x300", auto_orient: true).processed, host: context[:base_url])
    end
  end
end
