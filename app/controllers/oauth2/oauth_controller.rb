module Oauth2
  class OauthController < ApplicationController
		def login
			redirect_to Client.authorization_url
		end

		def callback
			login_token ||= Client.process_callback(params)
			if login_token
				cookies[:login_token] = login_token
				redirect_to_target_or_default(main_app.root_path, :notice => "Successfully Logged in")
			else
				redirect_to_target_or_default(main_app.root_path, :notice => "Logged failed")
			end
		end

		def logout
			if current_user
				if Client.logout_from_oauth(current_user)
					cookies.delete(:login_token)
					redirect_to main_app.root_url, :notice => "Logged Out!"
				else
					redirect_to main_app.root_url, :notice => "Problem logging out from the main server."
				end
			else
					redirect_to main_app.root_url, :notice => "Not Signed in!"
			end
		end
  end
end
