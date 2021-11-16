Rails.application.routes.draw do
  resources :boards
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'boards#index'
end
