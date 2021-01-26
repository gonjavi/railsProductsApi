Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :users, only: %i[index create destroy update show]
    # resources :categories, only: %i[index create destroy]
    # resources :products, only: %i[index]
  end
end
