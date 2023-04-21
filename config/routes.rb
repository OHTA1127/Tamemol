Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, only: [:new, :create, :index, :show, :destroy, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
