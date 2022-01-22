Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations]
  resources :quotes do
    resources :results, param: :uuid, only: %i[show create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get '*path', to: 'application#render_404'
end
