Rails.application.routes.draw do
  devise_for :users
  root to:"homes#top"

  resources :vtubers do
    resource :favorites,only:[:create,:destroy]
    resources :vtuber_comments,only:[:create,:destroy]
  end

  get "search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
