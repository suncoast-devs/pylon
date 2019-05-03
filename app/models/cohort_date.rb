class CohortDate < ApplicationRecord
  belongs_to :cohort

  has_many :attendance_records
end
