Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"

  get 'users/edit', to: 'users#edit' 
  post '/users/:id', to: 'users#custom_action'

  resources :users do
  member do
    post :custom_action
  end
end

  resources :books, only: [:index, :new, :create, :edit, :show, :destroy, :update]
  resources :users, only: [:create,:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
