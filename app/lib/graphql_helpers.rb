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
