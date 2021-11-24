Rails.application.routes.draw do
  resources :quotes do
    resources :results, param: :uuid, only: %i[show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
end
