require 'rails-caddy/session_controller_finder'

# Find the controller responsible for establishing session
session_controller = SessionControllerFinder.find

# Dynamically define the RailsCaddyController now
c = Class.new(session_controller) do
  include TimecopController
end
Object.const_set("RailsCaddyController", c)
