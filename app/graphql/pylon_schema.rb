class PylonSchema < GraphQL::Schema
  mutation Types::Mutation
  query Types::Query
  use GraphQL::Guard.new(
    not_authorized: -> (type, field) {
      GraphQL::ExecutionError.new("Not authorized to access #{type}.#{field}")
    },
  )
end
