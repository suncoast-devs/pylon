class HomeworkResource < ApplicationResource
  attribute :id, :integer
  attribute :name, :string
  attribute :body, :string
  attribute :title, :string, writable: false
  attribute :summary, :string
  attribute :turn_in_type, :string
  attribute :assigned, :boolean
  attribute :counts_towards_completion, :boolean
  attribute :due_at, :datetime
  attribute :assignments_count, :integer

  attribute :cohort_id, :integer
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  # Adding a virtual attribute to indicate we are reassigning this homework
  attribute :reassigned, :boolean

  attribute :body_with_resolved_urls, :string do
    @object.body.gsub("(/", "(https://handbook.suncoast.io/")
  end

  belongs_to :cohort
  has_many :assignments

  after_save do |model|
    # If we are assigning, or re-assigning this homework, then create the needed assignments
    if mode.reassigned || (model.assigned && model.assigned_previously_changed?)
      HomeworkAssignedJob.perform_later(homework: model)
    end
  end

  def base_scope
    return Homework.all.includes(assignments: :person) if admin?

    Homework.where(cohort_id: current_user.cohorts.pluck(:id))
  end
end
