class CohortsController < ApplicationController
  def index
    cohorts = CohortResource.all(params)
    respond_with(cohorts)
  end

  def show
    cohort = CohortResource.find(params)
    respond_with(cohort)
  end

  def create
    cohort = CohortResource.build(params)

    if cohort.save
      render jsonapi: cohort, status: 201
    else
      render jsonapi_errors: cohort
    end
  end

  def update
    cohort = CohortResource.find(params)

    if cohort.update_attributes
      render jsonapi: cohort
    else
      render jsonapi_errors: cohort
    end
  end

  def destroy
    cohort = CohortResource.find(params)

    if cohort.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: cohort
    end
  end
end
