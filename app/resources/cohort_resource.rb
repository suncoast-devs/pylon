class CohortResource < ApplicationResource
  attribute :name, :string
  attribute :start_date, :date
  attribute :end_date, :date
  attribute :program_id, :integer

  belongs_to :program

  has_many :homeworks
  has_many :progress_reports
  has_many :cohort_dates
  has_many :student_enrollments

  many_to_many :people

  attribute :active, :boolean do
    Date.today.between?(@object.start_date, @object.end_date)
  rescue
    false
  end

  filter :active, :boolean do
    eq do |scope, value|
      if value
        scope.where("start_date <= :today and end_date >= :today", today: Date.today)
      else
        scope.where.not("start_date <= :today and end_date >= :today", today: Date.today)
      end
    end
  end

  # many_to_many :units
  extra_attribute :units, :array do
    @object.units.to_a
  end

  def base_scope
    cohorts = admin? ? Cohort.all : current_user.cohorts

    cohorts.includes(:student_enrollments, :people, :homeworks)
  end
end
