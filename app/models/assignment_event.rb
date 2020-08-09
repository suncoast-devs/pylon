class AssignmentEvent < ApplicationRecord
  belongs_to :assignment, autosave: true
  belongs_to :person

  serialize :payload, JSON
end
