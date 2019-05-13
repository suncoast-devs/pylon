class ProgressReportResource < ApplicationResource
  attribute :id, :integer
  attribute :cohort_id, :integer
  attribute :start_date, :date
  attribute :end_date, :date
  attribute :ids_of_homeworks, :array
  attribute :ids_of_people, :array
  attribute :completed, :boolean
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :cohort
  has_many :student_progress_reports

  has_many :people, resource: PersonResource do
    params do |hash, progress_reports|
      ids = progress_reports.map(&:ids_of_people).flatten

      hash[:filter] = {id: ids}
    end

    assign do |progress_reports, people|
      progress_reports.each do |progress_report|
        progress_report.people = people.select { |person| person.id.in?(progress_report.ids_of_people) }
      end
    end
  end

  has_many :homeworks, resource: HomeworkResource do
    params do |hash, progress_reports|
      hash[:filter] = {id: progress_reports.map(&:ids_of_homeworks).flatten}
    end

    assign do |progress_reports, homeworks|
      progress_reports.each do |progress_report|
        progress_report.homeworks = homeworks.select { |homework| homework.id.in?(progress_report.ids_of_homeworks) }
      end
    end
  end
end
