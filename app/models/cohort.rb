class Cohort < ApplicationRecord
  belongs_to :program
  has_many :units, through: :program

  has_many :student_enrollments
  has_many :people, through: :student_enrollments

  has_many :cohort_dates
  has_many :attendance_records, through: :cohort_dates

  validates :name, presence: true, uniqueness: true

  after_create_commit :generate_dates

  private

  def generate_dates
    (start_date..end_date).reject(&:on_weekend?).each do |day|
      cohort_dates.create(day: day)
    end
  end
end
