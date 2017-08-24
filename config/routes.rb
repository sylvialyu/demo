Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :admin do
    resources :levels do
      resources :challenges
    end
  end

  resources :levels do
    resources :challenges
  end

  resource :user

end
