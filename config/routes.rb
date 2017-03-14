Rails.application.routes.draw do

  resources :customers do 
    resources :contacts
    resources :feature_requests, :except => [:index] do
      resources :features, :except => [:index]
    end
  end
  
  get 'feature_requests/', to: 'feature_requests#index', as: 'feature_requests'

end
