module Oauth2
	module Generators
		class SetupGenerator < Rails::Generators::NamedBase
			desc "Setup the config file for using oauth2 and copies the migration to the local application"

			def self.source_root
				@_oauth2_source_root ||= File.expand_path("../templates", __FILE__)
			end

			def setup
				template 'config/oauth.yml', 'config/oauth.yml'
				generate 'oauth2:install:migrations'
			end
		end
	end
end
