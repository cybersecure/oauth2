Oauth2::Engine.routes.draw do
	match '/login' => "oauth#login", :as => "login"
  match '/logout' => "oauth#logout", :as => "logout"
  match '/callback' => "oauth#callback", :as => "callback"
end
