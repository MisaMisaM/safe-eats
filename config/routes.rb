Rails.application.routes.draw do
  root to: "pages#home"
  resources :additives, only: [:index, :show]
  resources :allergens, only: [:index, :show]
  resources :scans, only: [:new, :create, :show] do
    post :capture, on: :collection
  end
end
