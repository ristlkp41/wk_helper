Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :service_members

    resource :service_member_import, only: [:new, :create]
  end

  namespace :zuko do
    resources :passages, only: [:new, :create]

    resources :attendees, only: [:index]
  end

end
