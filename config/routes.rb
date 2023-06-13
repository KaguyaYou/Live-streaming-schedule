Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to:"homes#top"

  resources :vtubers do
    resource :favorites,only:[:create,:destroy]
    resources :vtuber_comments,only:[:create,:destroy]
  end

  resources :chat_rooms do
    resources :messages
    collection do
      post 'create_chat_room'
    end
  end
  resources :users, only: [:index,:show,:edit,:update]

  get 'tagsearches/search', to: 'tagsearches#search'

  get "search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
