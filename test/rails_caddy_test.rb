require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

require 'rails-caddy'

class ApplicationController < ActionController::Base
  session_options[:key] = "abc"
end

class RailsCaddyTest < Test::Unit::TestCase
  
  context "RailsCaddy has been initialized" do
    setup do
      RailsCaddy.init!
    end
  
    should "add TimecopController::ActionControllerExtensions to ActionController::Base" do
      assert ActionController::Base.included_modules.include?(TimecopController::ActionControllerExtensions)
    end
    
    should "add SanitizeEmailController::ActionControllerExtensions to ActionController::Base" do
      assert ActionController::Base.included_modules.include?(SanitizeEmailController::ActionControllerExtensions)
    end
    
    should "load RailsCaddyController" do
      assert Object.const_defined?(:RailsCaddyController)
    end
    
    should "add rails-caddy/views to the view_path" do
      path = File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "rails-caddy", "views"))
      assert ActionController::Base.view_paths.include?(path)
    end
    
  end
    
end
