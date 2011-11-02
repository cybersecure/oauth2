module Oauth2
  class OauthController < ApplicationController
		def login
			redirect_to Client.authorization_url
		end

		def callback
			auth_token = Client.process_callback(params)
			if auth_token
				cookies[:auth_token] = auth_token
				redirect_to_target_or_default(main_app.root_path, :notice => "Successfully Logged in")
			else
				redirect_to_target_or_default(main_app.root_path, :notice => "Logged failed")
			end
		end

		def logout
			cookies.delete(:auth_token)
			if Client.logout_from_oauth(current_user)
				redirect_to main_app.root_url, :notice => "Logged Out!"
			else
				redirect_to main_app.root_url, :notice => "Problem logging out from the main server."
			end
		end
  end
end
