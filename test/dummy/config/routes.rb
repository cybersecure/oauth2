Rails.application.routes.draw do
  resources :posts
  mount Oauth2::Engine => "/oauth2"
  root :to => 'posts#index'
end
