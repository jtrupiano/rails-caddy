
require 'rails-caddy/errors'
require 'rails-caddy/controllers/rails-caddy_controller'

class RailsCaddy
  
  def self.init!
    @@rails_caddy ||= RailsCaddy.new
    controller = @@rails_caddy.send(:find_session_controller)
    controller.send(:include, RailsCaddyController)
  end
  
  private
  
    def initialize
    
    end
    
    def find_session_controller
      begin
        ApplicationController
      rescue NameError => er
        raise SessionControllerNotFoundError, "Cannot find ApplicationController"
      end
    end
  
end

#RailsCaddy.init!