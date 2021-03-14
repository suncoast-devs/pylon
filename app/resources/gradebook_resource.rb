class GradebookResource < ApplicationResource
  self.adapter = Graphiti::Adapters::Null

  belongs_to :cohort
  has_many :homeworks
  has_many :student_enrollments
  has_many :assignments

  def base_scope
    {}
  end

  filter :cohort_id, :integer do
    eq do |scope, value|
      scope[:id] = value
      scope
    end
  end

  def resolve(scope)
    Cohort.includes(:homeworks, student_enrollments: [:person, { assignments: :homework }, :cohort]).where(scope).map do |cohort|
      Gradebook.new(cohort)
    end
  end
end
