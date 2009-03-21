# Responsible for locating the controller responsible for establishing the session
class SessionControllerFinder
  def self.find
    if !Object.const_defined?(:ApplicationController)
      raise RailsCaddy::SessionControllerNotFoundError, 
        "Cannot find ApplicationController.  If you're sure that you have defined it, try adding require_dependency 'application_controller' prior to invoking RailsCaddy.init!"
    end
    
    candidate = ApplicationController
    # if candidate.session_options[:key].nil?
    #   raise RailsCaddy::SessionUninitializedError, 
    #     "session does not appear to be established for #{candidate.class}. session: #{candidate.session_options.inspect}"
    # end
    
    candidate
  end
end
