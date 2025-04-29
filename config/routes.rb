Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"

  resources :users, only: [:create, :index, :show, :edit, :update] do
    member do
      post :custom_action
    end
  end

  devise_scope :user do
    post "guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  

  resources :books, only: [:index, :new, :create, :edit, :show, :destroy, :update]
end
