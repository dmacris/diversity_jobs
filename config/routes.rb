Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :wip, only: :index

  match '*unmatched', to: 'application#not_found_method', via: :all
end
