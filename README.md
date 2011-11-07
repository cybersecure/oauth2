OAuth2
======

This gem provides the client side implementation for authenticating against oauth2 server running
on a port specified in the configuration file located under *config* folder.

Installation
------------

Add the following source to your Gemfile

	gem 'oauth2', :git => 'git://github.com:jaischeema/oauth2.git'

And run 

	bundle install
	rails g oauth:install

This should place everything in the proper places and add the routes as well.

Just make sure, before starting the server, run the following command.

	rake db:migrate

Usage
-----

The configuration file is located under *config/oauth.yml*
Change the app_id, app_secret, client_url and server url accordingly.

This engine provides following methods to be used in controllers:

	* login_required - can be used as before_filter
	* current_user - get the current user who is logged in
	* logged_in? - check if anyone is logged in, if yes, then return the user instance
	* redirect_to_target_or_default - redirect to the last requested url or root url

Notes
-----

Please make sure you take care of these two considerations

	* Make sure you *NEVER* change the path this engine is mounted on, as it needs to be fixed, this depends on
	  engine having the mount path as /oauth2
	* Always defined root_url in your main application, as it relies on root_url
