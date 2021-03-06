Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  namespace :admin do
    resources :service_members
    resource :service_member_import, only: [:new, :create]

    resources :users
  end

  namespace :zuko do
    resources :passages, only: [:new, :create]

    resources :attendees, only: [:index]
  end

end
