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
    resources :lecture_videos
    resources :units
    resources :programs
    resources :student_enrollments
    resources :progress_reports
    resources :student_progress_reports
    resources :handbook_assignments

    resources :repositories, only: [:index]
    resources :gists, only: [:index]
    resources :lecture_video_playbacks, only: [:create]
  end

  get "/redeem" => "people#redeem"
  get "/auth/:provider" => "omniauth#auth", as: :auth
  get "/auth/:provider/callback" => "session#create"
  get "/auth/failure" => "session#failure"

  get "/login" => "session#new"
  post "/login" => "session#create"
  get "/logout" => "session#destroy"

  post "/zoom-webhooks/new-recording" => "zoom_webhooks#new_recording"
  post "/zoom-webhooks/new-meeting" => "zoom_webhooks#new_meeting"
  post "/zoom-webhooks/participant-joined-meeting" => "zoom_webhooks#participant_joined_meeting"
  post "/zoom-webhooks/participant-left-meeting" => "zoom_webhooks#participant_left_meeting"
end
