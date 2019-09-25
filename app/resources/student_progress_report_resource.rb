class StudentProgressReportResource < ApplicationResource
  attribute :id, :integer
  attribute :progress_report_id, :integer
  attribute :person_id, :integer
  attribute :content, :hash
  attribute :report_image_data, :string, readable: false

  belongs_to :progress_report
  belongs_to :person

  def base_scope
    return StudentProgressReport.all if admin?

    return current_user.student_progress_reports.joins(:progress_report).merge(ProgressReport.completed)
  end

  attribute :report_image_url, :string do
    uri = URI.parse(context.request.original_url)
    base_url = "#{uri.scheme}://#{uri.host}:#{uri.port}"

    @object.report_image.attached? ? context.rails_blob_url(@object.report_image, disposition: "attachment") : nil
  rescue Aws::S3::Errors::NotFound, Errno::ENOENT => ex
  end
end
