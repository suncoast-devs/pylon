class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.comment(field)
    field = field.to_s

    columns.find { |column| column.name == field }.try(:comment)
  end
end
