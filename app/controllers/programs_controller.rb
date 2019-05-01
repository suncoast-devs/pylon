class ProgramsController < ApplicationController
  def index
    programs = ProgramResource.all(params)
    respond_with(programs)
  end

  def show
    program = ProgramResource.find(params)
    respond_with(program)
  end

  def create
    program = ProgramResource.build(params)

    if program.save
      render jsonapi: program, status: 201
    else
      render jsonapi_errors: program
    end
  end

  def update
    program = ProgramResource.find(params)

    if program.update_attributes
      render jsonapi: program
    else
      render jsonapi_errors: program
    end
  end

  def destroy
    program = ProgramResource.find(params)

    if program.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: program
    end
  end
end
