
require 'rails-caddy/errors'
require 'rails-caddy/controllers/rails-caddy_controller'

class RailsCaddy
  
  def self.init!
    @@rails_caddy ||= RailsCaddy.new
    controller = @@rails_caddy.send(:find_session_controller)
	  if controller.session.nil? || (controller.session.is_a?(Array) && !controller.session.any? {|hsh| hsh.is_a?(Hash) && !hsh[:session_key].nil?})
      raise SessionUninitializedError
	  end
	  # including this controller isn't right....we actually want to make it its own controller...
    controller.send(:include, RailsCaddyController)
    ActionController::Base.append_view_path(File.expand_path(File.join(File.dirname(__FILE__), "rails-caddy", "views")))
  end
  
  private
  
    def initialize
    
    end
    
    def find_session_controller
	    raise SessionControllerNotFoundError, "Cannot find ApplicationController" if !Object.const_defined?(:ApplicationController)
      ApplicationController
    end
  
end

#RailsCaddy.init!