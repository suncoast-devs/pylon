class Person < ApplicationRecord
  has_many :emails, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :student_profiles, dependent: :destroy
end
