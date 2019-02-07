Rails.application.routes.draw do
  post "/", to: "graphql#execute", as: :query
end
