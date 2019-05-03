class AttendanceRecordsController < ApplicationController
  def index
    attendance_records = AttendanceRecordResource.all(params)
    respond_with(attendance_records)
  end

  def show
    attendance_record = AttendanceRecordResource.find(params)
    respond_with(attendance_record)
  end

  def create
    attendance_record = AttendanceRecordResource.build(params)

    if attendance_record.save
      render jsonapi: attendance_record, status: 201
    else
      render jsonapi_errors: attendance_record
    end
  end

  def update
    attendance_record = AttendanceRecordResource.find(params)

    if attendance_record.update_attributes
      render jsonapi: attendance_record
    else
      render jsonapi_errors: attendance_record
    end
  end

  def destroy
    attendance_record = AttendanceRecordResource.find(params)

    if attendance_record.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: attendance_record
    end
  end
end
