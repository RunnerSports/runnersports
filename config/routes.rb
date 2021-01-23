Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: "pages#index"

  resources :products
  resources :courses do
    resources :user_courses, except: [:index]
  end

  resources :user_courses, only: [:index]
end
