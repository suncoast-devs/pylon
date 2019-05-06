class Person < ApplicationRecord
  has_many :emails, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :addresses, dependent: :destroy, as: :addressable
  has_many :links, dependent: :destroy, as: :linkable
  has_one  :student_profile, dependent: :destroy
  has_many :student_enrollments, dependent: :destroy
  has_many :cohorts, through: :student_enrollments

  has_one :user

  has_many :attendance_records

  has_one_attached :profile_image

  def needs_profile_image?
    !profile_image.attached?
  end
end
