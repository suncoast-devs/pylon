class StudentEnrollmentsController < ApplicationController
  def index
    student_enrollments = StudentEnrollmentResource.all(params)
    respond_with(student_enrollments)
  end

  def show
    student_enrollment = StudentEnrollmentResource.find(params)
    respond_with(student_enrollment)
  end

  def create
    student_enrollment = StudentEnrollmentResource.build(params)

    if student_enrollment.save
      render jsonapi: student_enrollment, status: 201
    else
      render jsonapi_errors: student_enrollment
    end
  end

  def update
    student_enrollment = StudentEnrollmentResource.find(params)

    if student_enrollment.update_attributes
      render jsonapi: student_enrollment
    else
      render jsonapi_errors: student_enrollment
    end
  end

  def destroy
    student_enrollment = StudentEnrollmentResource.find(params)

    if student_enrollment.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: student_enrollment
    end
  end
end
