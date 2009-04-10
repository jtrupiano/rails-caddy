require 'timecop'
require 'rails-caddy/errors'
require 'rails-caddy/controllers/action_controller_extensions'
require 'rails-caddy/controllers/session_editing_controller'
require 'rails-caddy/controllers/timecop_controller'
require 'rails-caddy/helpers/rails_caddy_helper'

$rails_caddy_activated = false

class RailsCaddy
  
  def self.init!
    # extend ActionController::Base
    ActionController::Base.send(:include, ActionControllerExtensions)
    	  
	  # Pull in the RailsCaddyController
	  require 'rails-caddy/controllers/rails_caddy_controller'
	      
    # Lastly, let's add our views to the load path...
    ActionController::Base.append_view_path(File.expand_path(File.join(File.dirname(__FILE__), "rails-caddy", "views")))
    
    # we will inspect this at a few places in the consuming rails app, most notably config/routes.rb
    $rails_caddy_activated = true
  end
  
  def self.define_routes!(map)
    # Timecop routes
    map.timecop_update '/rails_caddy/timecop_update', :controller => 'rails_caddy', :action => 'timecop_update'
    map.timecop_reset '/rails_caddy/timecop_reset', :controller => 'rails_caddy', :action => 'timecop_reset'

    map.update_session '/rails_caddy/update_session/:id', :controller => 'rails_caddy', :action => 'update_session'
    map.remove_session '/rails_caddy/remove_session/:id', :controller => 'rails_caddy', :action => 'remove_session'
  end
    
end
