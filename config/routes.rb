Rails.application.routes.draw do
  root to: "pages#home"
  resources :additives, only: [:index, :show]
  resources :allergens, only: [:index, :show]

  resources :scans, only: [:new, :create, :show, :destroy] do
    post :capture, on: :collection
    delete :delete, on: :member # Add a custom route for deleting images
  end
end
