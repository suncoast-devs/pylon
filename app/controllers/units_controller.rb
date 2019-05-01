class UnitsController < ApplicationController
  def index
    units = UnitResource.all(params)
    respond_with(units)
  end

  def show
    unit = UnitResource.find(params)
    respond_with(unit)
  end

  def create
    unit = UnitResource.build(params)

    if unit.save
      render jsonapi: unit, status: 201
    else
      render jsonapi_errors: unit
    end
  end

  def update
    unit = UnitResource.find(params)

    if unit.update_attributes
      render jsonapi: unit
    else
      render jsonapi_errors: unit
    end
  end

  def destroy
    unit = UnitResource.find(params)

    if unit.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: unit
    end
  end
end
