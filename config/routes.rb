Rails.application.routes.draw do

  resources :customers do 
    resources :contacts
    resources :feature_requests, :except => [:index] do
      resources :features, :except => [:index]
    end
  end

  resources :dashboards, :except => [:show]
  
  get 'dashboard', to:'dashboards#index', as: 'dashboard_index'
  get 'feature_requests/', to: 'feature_requests#index', as: 'feature_requests'
  post 'feature_requests/', to: 'feature_requests#new'

  root to: 'feature_requests#index'
end
