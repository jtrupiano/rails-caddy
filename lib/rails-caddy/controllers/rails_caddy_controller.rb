require 'rails-caddy/session_controller_finder'

# Find the controller responsible for establishing session
session_controller = SessionControllerFinder.find

# Dynamically define the RailsCaddyController now
c = Class.new(session_controller) do
  include SessionEditingController
  include TimecopController
  
  before_filter :ensure_session_key_is_valid, :only => [:update_session, :remove_session]
  
  def verify_authenticity_token
    # this is lame that I have to override it here...can't figure out why a skip_before_filter fails
  end
  
end
Object.const_set("RailsCaddyController", c)
