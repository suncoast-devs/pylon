Rails.application.routes.draw do
  post "/", to: "graphql#execute", as: :query

  get    '/auth/:provider'          => 'omniauth#auth',  as: :auth
  get    '/auth/:provider/callback' => 'session#create'
  get    '/auth/failure'            => 'session#failure'

  get    '/login'  => 'session#new'
  post   '/login'  => 'session#create'
  get    '/logout' => 'session#destroy'
end
