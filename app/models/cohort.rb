class Cohort < ApplicationRecord
  has_many :units
  has_many :programs, through: :units

  has_many :student_enrollments, dependent: :nullify
  has_many :people, through: :student_enrollments

  has_many :cohort_dates

  validates :name, presence: true, uniqueness: true

  after_create_commit :generate_dates

  private

  def generate_dates
    (start_date..end_date).reject(&:on_weekend?).each do |day|
      cohort_dates.create(day: day)
    end
  end
end
