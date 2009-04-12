require 'timecop'
require 'actionmailer' # would like to remove this
require 'sanitize_email'
require 'rails-caddy/errors'
require 'rails-caddy/controllers/session_editing_controller'
require 'rails-caddy/controllers/timecop_controller'
require 'rails-caddy/controllers/sanitize_email_controller'
require 'rails-caddy/helpers/rails_caddy_helper'

$rails_caddy_activated = false

class RailsCaddy
  
  def self.init!
    # extend ActionController::Base
    ActionController::Base.send(:include, TimecopController::ActionControllerExtensions)
    ActionController::Base.send(:include, SanitizeEmailController::ActionControllerExtensions)
    
	  # Pull in the RailsCaddyController
	  require 'rails-caddy/controllers/rails_caddy_controller'
	      
    # Lastly, let's add our views to the load path...
    ActionController::Base.append_view_path(File.expand_path(File.join(File.dirname(__FILE__), "rails-caddy", "views")))
    
    # we will inspect this at a few places in the consuming rails app, most notably config/routes.rb
    $rails_caddy_activated = true
  end
  
  def self.define_routes!(map)
    # Session editing routes
    map.update_session '/rails_caddy/update_session/:id', :controller => 'rails_caddy', :action => 'update_session'
    map.remove_session '/rails_caddy/remove_session/:id', :controller => 'rails_caddy', :action => 'remove_session'

    # Timecop routes
    map.timecop_update '/rails_caddy/timecop_update', :controller => 'rails_caddy', :action => 'timecop_update'
    map.timecop_reset '/rails_caddy/timecop_reset', :controller => 'rails_caddy', :action => 'timecop_reset'

    # Sanitize Email routes
    map.set_sanitize_email_address '/rails_caddy/set_sanitize_email_address', :controller => 'rails_caddy', :action => 'set_sanitize_email_address'
    map.unset_sanitize_email_address '/rails_caddy/unset_sanitize_email_address', :controller => 'rails_caddy', :action => 'unset_sanitize_email_address'
  end
    
end
