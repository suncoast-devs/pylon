class GraphQL::Schema::Field
  def admin!
    guard -> (obj, args, ctx) { ctx[:current_user]&.is_admin? }
    mask -> (ctx) { ctx[:current_user]&.is_admin? }
  end

  def logged_in!
    guard -> (obj, args, ctx) { ctx[:current_user].present? }
    mask -> (ctx) { ctx[:current_user].present? }
  end
end

class PylonSchema < GraphQL::Schema
  mutation Types::Mutation
  query Types::Query
  use GraphQL::Guard.new(
    not_authorized: -> (type, field) {
      GraphQL::ExecutionError.new("Not authorized to access #{type}.#{field}")
    }
  )
end
