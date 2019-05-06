class ProfilesController < ApplicationController
  def index
    if current_user
      person = ProfileResource.find(id: current_user.person_id)

      respond_with(person)
    else
      respond_with([])
    end
  end

  def update
    person = ProfileResource.find(params)

    if params[:data][:id].to_i == current_user.person_id && person.update_attributes
      render jsonapi: person
    else
      render jsonapi_errors: person
    end
  end
end