Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'levels#index'

  namespace :admin do
    resources :levels do
      resources :challenges
    end
  end

  resources :levels do
    resources :challenges
  end

end
