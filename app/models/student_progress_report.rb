require "data_uri/open_uri"

class StudentProgressReport < ApplicationRecord
  belongs_to :progress_report
  belongs_to :person

  has_one_attached :report_image

  def report_image_data=(data)
    report_image.attach(filename: reporT_image_filename, io: URI::Data.new(data).open)
  end

  def report_image_filename
    "Progress Report for #{person.full_name} between #{progress_report.start_date} and #{progress_report.end_date}.png"
  end
end
