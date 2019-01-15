Rails.application.routes.draw do
  resources :events
  post 'authenticate', to: 'authentication#authenticate'
  resources :users, :events, :bikes
end
