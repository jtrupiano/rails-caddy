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
	  
	  # Now let's add our routes (only execute in 2.3.x)
	  if ActionController::Routing.const_defined?(:Routes)
	    ActionController::Routing::Routes.draw do |map|
	      define_routes!(map)
	    end
    end
    
	  require 'rails-caddy/routes'
	  
    # Lastly, let's add our views to the load path...
    ActionController::Base.append_view_path(File.expand_path(File.join(File.dirname(__FILE__), "rails-caddy", "views")))
  end
  
  def self.define_routes!(map)
    # Timecop routes
    map.timecop_update '/rails_caddy/timecop_update', :controller => 'rails_caddy', :action => 'timecop_update'
    map.timecop_reset '/rails_caddy/timecop_reset', :controller => 'rails_caddy', :action => 'timecop_reset'
    
  end
    
end
