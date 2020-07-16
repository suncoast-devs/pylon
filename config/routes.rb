Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :progress_reports
    resources :assignments
    resources :assignment_events, only: [:index, :create]
    resources :homeworks
    resources :attendance_records
    resources :cohort_dates
    resources :profiles
    resources :people
    resources :cohorts
    resources :units
    resources :programs
    resources :student_enrollments
    resources :progress_reports
    resources :student_progress_reports

    resources :repositories, only: [:index]
    resources :gists, only: [:index]
  end

  get "/redeem" => "people#redeem"
  get "/auth/:provider" => "omniauth#auth", as: :auth
  get "/auth/:provider/callback" => "session#create"
  get "/auth/failure" => "session#failure"

  get "/login" => "session#new"
  post "/login" => "session#create"
  get "/logout" => "session#destroy"

  post "/new-recording" => "recordings#create"
end
