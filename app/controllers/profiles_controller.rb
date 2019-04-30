class ProfilesController < ApplicationController
  def index
    if current_user
      person = ProfileResource.find(id: current_user.person_id)

      respond_with(person)
    else
      respond_with([])
    end
  end
end