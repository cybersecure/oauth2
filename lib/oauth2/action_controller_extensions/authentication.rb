module Oauth2
	module ActionControllerExtensions
		module Authentication
			
			private 
			def current_user
				if cookies[:auth_token]
					@current_user ||= User.find_by_login_token!(cookies[:auth_token])
				else
					nil
				end
			end

			def logged_in?
				current_user
			end

			def login_required
				unless logged_in?
					store_target_location
					redirect_to oauth2.login_url
				end
			end

			def redirect_to_target_or_default(default, *args)
				redirect_to(session[:return_to] || default, *args)
				session[:return_to] = nil
			end
			
			def store_target_location
				session[:return_to] = request.url
			end
			
		end
	end
end

ActionController::Base.send(:include,Oauth2::ActionControllerExtensions::Authentication)
ActionController::Base.send(:helper_method, :current_user, :logged_in?, :redirect_to_target_or_default, :login_required )
