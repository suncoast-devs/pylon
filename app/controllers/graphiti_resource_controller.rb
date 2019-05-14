class GraphitiResourceController < ApplicationController
  def resource
    "#{self.class.name.gsub(/Controller$/, "").singularize}Resource".constantize
  end

  def index
    records = self.resource.all(params)
    respond_with(records)
  end

  def show
    record = self.resource.find(params)
    respond_with(record)
  end

  def create
    record = self.resource.build(params)

    if record.save
      render jsonapi: record, status: 201
    else
      render jsonapi_errors: record
    end
  end

  def update
    @record = self.resource.find(params)

    if @record.update_attributes
      render jsonapi: @record
    else
      render jsonapi_errors: @record
    end
  end

  def destroy
    record = self.resource.find(params)

    if record.destroy
      render jsonapi: {meta: {}}, status: 200
    else
      render jsonapi_errors: record
    end
  end
end
