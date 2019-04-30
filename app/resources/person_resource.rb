class PersonResource < ApplicationResource
  attribute :given_name, :string
  attribute :family_name, :string
  attribute :additional_name, :string
  attribute :honorific_prefix, :string
  attribute :honorific_suffix, :string
  attribute :nickname, :string
  attribute :full_name, :string
  attribute :shirt_size, :string
  attribute :dietary_note, :string
end
