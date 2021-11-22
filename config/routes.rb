Rails.application.routes.draw do
  resources :quotes, only: %i[index show edit update new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
end
