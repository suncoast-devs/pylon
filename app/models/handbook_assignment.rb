class HandbookAssignment
  attr_accessor :id
  attr_accessor :name
  attr_accessor :body

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @body = attributes[:body]
  end
end
