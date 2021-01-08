class HandbookAssignmentResource < ApplicationResource
  self.adapter = Graphiti::Adapters::Null

  attribute :id, :integer
  attribute :name, :string
  extra_attribute :body, :hash do
    GithubInterface.handbook_assignment_content(@object.name)
  end

  filter :id, only: [:eq] do
    eq do |scope, value|
      scope[:filters][:id] = value
      scope
    end
  end

  def base_scope
    { sort: {}, filters: {} }
  end

  def resolve(scope)
    assignments = GithubInterface.handbook_assignment_names.map.with_index { |name, index| HandbookAssignment.new(id: index, name: File.basename(name, ".*")) }
    if scope[:filters] && scope[:filters][:id]
      id = scope[:filters][:id].first

      assignments.select { |assignment| assignment.id == id }
    else
      assignments
    end
  end
end
