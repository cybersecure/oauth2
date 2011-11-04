require 'net/http'

module Oauth2
	module Client
		
		@@config = YAML.load_file("#{Rails.root}/config/oauth.yml")
		@@paths = YAML.load_file("#{Engine.root}/config/oauth.yml")
		@@redirect_url = "#{@@config['client_url']}/oauth2/callback"

		def self.authorization_url
			"#{self.url_for('authorization')}?client_id=#{@@config['client_id']}&redirect_uri=#{@@redirect_url}"
		end

		def self.url_for(key)
			"#{@@config['server_url']}#{@@paths[key]}"
		end

		def self.process_callback(params)
			code ||= params[:code]
			unless code.nil?
				post_params = {
					:client_id => @@config['client_id'],
					:client_secret => @@config['client_secret'],
					:code => code
				}
				response = self.post(self.url_for('access_token'),post_params)
				response_hash = ActiveSupport::JSON.decode(response)
				access_token ||= response_hash['access_token']
				if access_token
					user_response = self.get_user(access_token)
					user_hash = ActiveSupport::JSON.decode(user_response)
					user = User.update_or_create_access_user(user_hash,code,response_hash)
					if user  
						user.login_token
					else 
						nil
					end
				else
					raise "Access Token was not received"
				end
			else
				raise "Authentication code was not received"
			end
		end

		def self.logout_from_oauth(user)
			response = self.post(self.url_for('logout'),{:access_token => user.access_token})
			response_hash = ActiveSupport::JSON.decode(response)
			response_hash['logout'] ? true : false
		end

		def self.get_user(access_token)
			post_params = {
				:access_token => access_token
			}
			response = self.post(self.url_for('user_info'),post_params)
		end


		def self.post(uri,params)
			url = URI.parse(uri)
			req = Net::HTTP::Post.new(url.path)
			req.body = JSON.generate(params)
			req["Content-Type"] = "application/json"
			http = Net::HTTP.new(url.host,url.port)
			response = http.start { |htt| htt.request(req) }
			response.body
		end

		def self.get(uri,params)
			url = URI.parse(uri)
			req = Net::HTTP::Get.new(url.path)
			req.body = JSON.generate(params)
			req["Content-Type"] = "application/json"
			http = Net::HTTP.new(url.host,url.port)
			response = http.start { |htt| htt.request(req) }
			response
		end
	end
end
