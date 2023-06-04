Rails.application.routes.draw do
  devise_for :users
  root to:"homes#top"
  get 'home/about'=>'homes#about',as:'about'

  resources :lists, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites,only:[:create,:destroy]
    resources :list_comments,only:[:create,:destroy]
  end

  get "search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
