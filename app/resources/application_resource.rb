# ApplicationResource is similar to ApplicationRecord - a base class that
# holds configuration/methods for subclasses.
# All Resources should inherit from ApplicationResource.
class ApplicationResource < Graphiti::Resource
  # Use the ActiveRecord Adapter for all subclasses.
  # Subclasses can still override this default.
  self.abstract_class = true
  self.adapter = Graphiti::Adapters::ActiveRecord
  self.base_url = Rails.application.routes.default_url_options[:host]
  self.endpoint_namespace = "/api/v1"

  # Make the default pagination very large (for now)
  # HACK: a bit of a hack to get around not being great
  #       at pagination in the client in all cases
  self.default_page_size = 999

  def admin?
    current_user.is_admin?
  end

  def current_person
    context.current_person
  end

  def current_user
    context.current_user
  end
end
