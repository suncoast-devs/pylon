class Homework < ApplicationRecord
  belongs_to :cohort

  has_many :assignments

  # Virtual attribute to use to re-assign an assignment
  attr_accessor :reassigned

  def title
    "#{name} - #{summary}"
  end
end
