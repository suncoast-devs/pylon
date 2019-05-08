class Homework < ApplicationRecord
  belongs_to :cohort

  has_many :assignments

  def title
    "#{name} - #{summary}"
  end
end
