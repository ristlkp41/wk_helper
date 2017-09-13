Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :service_members
  end

  namespace :zuko do
    resources :passages, only: [:new, :create]
  end

end
