module Oauth2
	module Generators
		class InstallGenerator < Rails::Generators::Base
			desc "Setup the config file for using oauth2 and copies the migration to the local application"

			def self.source_root
				@_oauth2_source_root ||= File.expand_path("../templates", __FILE__)
			end

			def install
				template 'config/oauth.yml', 'config/oauth.yml'
				rake 'oauth2:install:migrations'
				route 'mount Oauth2::Engine => "/oauth2"'
			end
		end
	end
end
