Rails.application.routes.draw do
  resources :games
  root 'application#index'
  get '*path' => 'application#index'
end
