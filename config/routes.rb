Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  root to: 'mono_chords#home'
  get 'mono_chords/home'
  get '/help', to: 'mono_chords#help'
  get '/about', to: 'mono_chords#about'
  get '/terms', to: 'mono_chords#terms'
  get '/privacy', to: 'mono_chords#privacy'
  get '/users/:id', to: 'mono_chords#show', as: :show
  get '/users/:id/edit', to: 'mono_chords#edit', as: :edit
  patch '/users/:id/edit', to: 'mono_chords#update'
  #resources :users, path: '/', only: [:show, :edit, :update, :destroy]
  get '/users/:id/songs/practiced' => 'songs#practiced', as: :practiced
  get '/users/:id/songs/practicing' => 'songs#practicing', as: :practicing
  get '/users/:id/songs/wish' => 'songs#wish', as: :wish
  resources :users do
    member do
      get :following, :followers
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
