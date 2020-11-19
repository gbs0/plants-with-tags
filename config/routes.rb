Rails.application.routes.draw do
  root to: "gardens#index"
  resources :gardens do
    resources :plants, only: [:create]
  end

  resources :plants, only: [:new, :create, :destroy] do
  	resources :plant_tags, only: [:new, :create]
  end

  resources :plant_tags, only: [:destroy]
end
