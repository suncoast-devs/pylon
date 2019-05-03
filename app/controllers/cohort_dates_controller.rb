class CohortDatesController < ApplicationController
  def index
    cohort_dates = CohortDateResource.all(params)
    respond_with(cohort_dates)
  end

  def show
    cohort_date = CohortDateResource.find(params)
    respond_with(cohort_date)
  end

  def create
    cohort_date = CohortDateResource.build(params)

    if cohort_date.save
      render jsonapi: cohort_date, status: 201
    else
      render jsonapi_errors: cohort_date
    end
  end

  def update
    cohort_date = CohortDateResource.find(params)

    if cohort_date.update_attributes
      render jsonapi: cohort_date
    else
      render jsonapi_errors: cohort_date
    end
  end

  def destroy
    cohort_date = CohortDateResource.find(params)

    if cohort_date.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: cohort_date
    end
  end
end
