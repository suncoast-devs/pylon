class PeopleController < ApplicationController
  def index
    people = PersonResource.all(params)
    respond_with(people)
  end

  def show
    person = PersonResource.find(params)
    respond_with(person)
  end

  def create
    person = PersonResource.build(params)

    if person.save
      render jsonapi: person, status: 201
    else
      render jsonapi_errors: person
    end
  end

  def update
    person = PersonResource.find(params)

    if person.update_attributes
      render jsonapi: person
    else
      render jsonapi_errors: person
    end
  end

  def destroy
    person = PersonResource.find(params)

    if person.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: person
    end
  end
end
