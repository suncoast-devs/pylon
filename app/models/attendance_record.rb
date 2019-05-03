class AttendanceRecord < ApplicationRecord
  belongs_to :person
  belongs_to :cohort_date
end
