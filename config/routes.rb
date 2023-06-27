Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to:"homes#top"

  resources :vtubers do
    resource :favorites,only:[:create,:destroy]
    resources :vtuber_comments,only:[:create,:destroy]
  end

  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :chats, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :favorites
      get :confirm
    end
  end

  get "search_tag"=>"vtubers#search_tag"

  get "search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
