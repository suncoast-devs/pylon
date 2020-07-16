class HomeworkResource < ApplicationResource
  attribute :id, :integer
  attribute :name, :string
  attribute :body, :string
  attribute :title, :string, writable: false
  attribute :summary, :string
  attribute :turn_in_type, :string
  attribute :counts_towards_completion, :boolean
  attribute :due_at, :datetime
  attribute :assignments_count, :integer

  attribute :cohort_id, :integer
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :cohort
  has_many :assignments

  def base_scope
    return Homework.all.includes(assignments: :person) if admin?

    Homework.where(id: current_user.cohorts.flat_map(&:homework_ids))
  end
end
