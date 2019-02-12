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

# This overrides the default field method to automatically include
# a description for the field from the corresponding table/field comment
module AutoDescription
  def self.included(base)
    base.instance_eval do
      def field(name = nil, type = nil, desc = nil, **kwargs, &block)
        desc = desc || "::#{self.name.split("::").last}".constantize.comment(name)

        super(name, type, desc, **kwargs, &block)
      end
    end
  end
end
