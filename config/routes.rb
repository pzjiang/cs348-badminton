Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # devise_for :users, controllers: { sessions: 'users/sessions' }

  # Create default resource sets for all the tables
  resources :games
  resources :challenges
  resources :teams
  resources :practices
  resources :practice_attendances
  resources :game_attendances
  resources :messages

  # TODO

  # user
  # join_req
end