Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end
  root 'welcome#index'
  post "/graphql", to: "graphql#execute"
  resources :episodes
  resources :podcasts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
