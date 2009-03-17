require 'timecop'
require 'rails-caddy/errors'
require 'rails-caddy/controllers/action_controller_extensions'
require 'rails-caddy/controllers/timecop_controller'
require 'rails-caddy/helpers/rails_caddy_helper'

class RailsCaddy
  
  def self.init!
    # extend ActionController::Base
    ActionController::Base.send(:include, ActionControllerExtensions)
    	  
	  # Pull in the RailsCaddyController
	  require 'rails-caddy/controllers/rails_caddy_controller'
	  
	  # Now let's add our routes
	  require 'rails-caddy/routes'
	  
    # Lastly, let's add our views to the load path...
    ActionController::Base.append_view_path(File.expand_path(File.join(File.dirname(__FILE__), "rails-caddy", "views")))
  end
    
end
