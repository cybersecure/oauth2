module Oauth2
  class User < ActiveRecord::Base
		attr_accessible :username

		validates_uniqueness_of :username
		validates_presence_of :username, :access_token, :auth_token
		
		before_create { generate_token(:login_token) }
		
		def generate_token(column)
			begin
				self[column] = SecureRandom.urlsafe_base64
			end while User.exists?(column => self[column])
		end

		def self.update_or_create_access_user(user_hash, auth_token, access_token_hash)
			username ||= user_hash['username']
			if username
				user = self.find_by_username(username)
				if user
					user.auth_token = auth_token
					user.assign_tokens(access_token_hash)
				else
					user = User.new
					user.username = username
					user.auth_token = auth_token
					user.assign_tokens(access_token_hash)
				end
				if user.save
					user
				else
					nil
				end
			else
				nil
			end
		end

		def assign_tokens(access_token_hash)
			self.access_token = access_token_hash['access_token']
			self.refresh_token = access_token_hash['refresh_token'] if access_token_hash['refresh_token']
			self.expires_in = access_token_hash['expires_in']
		end
  end
end
