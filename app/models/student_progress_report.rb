require "data_uri/open_uri"

class StudentProgressReport < ApplicationRecord
  belongs_to :progress_report
  belongs_to :person

  has_one_attached :report_image

  def report_image_data=(data)
    report_image.attach(filename: "progress_report.png", io: URI::Data.new(data).open)
  end
end
