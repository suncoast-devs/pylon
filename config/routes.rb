Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :assignments
    resources :homeworks
    resources :attendance_records
    resources :cohort_dates
    resources :profiles
    resources :people
    resources :cohorts
    resources :units
    resources :programs
    resources :student_enrollments
    mount VandalUi::Engine, at: '/vandal'
    # your routes go here
  end

  get '/foo' => 'vandal_ui/schemas#show'

  get    '/auth/:provider'          => 'omniauth#auth',  as: :auth
  get    '/auth/:provider/callback' => 'session#create'
  get    '/auth/failure'            => 'session#failure'

  get    '/login'  => 'session#new'
  post   '/login'  => 'session#create'
  get    '/logout' => 'session#destroy'
end
