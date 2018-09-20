class Person < ApplicationRecord
  has_many :emails
  has_many :phone_numbers
  has_many :addresses
  has_many :links
  has_many :student_profiles
end
