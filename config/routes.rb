Rails.application.routes.draw do

  resources :customers do 
    resources :contacts
  end
  
end
