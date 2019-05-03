class Cohort < ApplicationRecord
  has_many :units
  has_many :programs, through: :units
  has_many :people, through: :units

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
