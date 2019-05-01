Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :profiles
    resources :people
    resources :cohorts
    resources :units
    resources :programs
    mount VandalUi::Engine, at: '/vandal'
    # your routes go here
  end

  get    '/auth/:provider'          => 'omniauth#auth',  as: :auth
  get    '/auth/:provider/callback' => 'session#create'
  get    '/auth/failure'            => 'session#failure'

  get    '/login'  => 'session#new'
  post   '/login'  => 'session#create'
  get    '/logout' => 'session#destroy'
end
