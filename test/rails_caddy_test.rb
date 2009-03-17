require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

require 'rails-caddy'

class RailsCaddyTest < Test::Unit::TestCase
  
  def setup
    # There's no guarantee which order these are run in, so we'll just remove it from the ObjectSpace altogether
    [:ApplicationController, :RailsCaddyController].each do |cont|
      Object.send(:remove_const, cont) if Object.const_defined?(cont)
    end
    
  end
  
  context "ApplicationController has not been defined" do    
    should "raise exception when initializing RailsCaddy" do
      assert_raise(RailsCaddy::SessionControllerNotFoundError) { RailsCaddy.init! }
    end
  end
  
  context "ApplicationController has been defined" do
  
    setup do
      class ::ApplicationController < ActionController::Base
        session_options[:key] = nil
      end
    end
    
    context "session has not been initialized, but the key is nil" do
      setup do
        ::ApplicationController.session_options[:key] = nil
      end
      
      should "raise SessionUninitializedError when initializing RailsCaddy" do
        assert_raise(RailsCaddy::SessionUninitializedError) { RailsCaddy.init! }
      end
    end
    
    context "session has been initialized" do
      setup do
        ::ApplicationController.session_options[:key] = "blah"
      end
      
      should "not raise exception when initializing RailsCaddy" do
        assert_nothing_raised { RailsCaddy.init! }
      end
      
      context "RailsCaddy has been initialized" do
        
        setup do
          RailsCaddy.init!
        end
      
        should "add rails-caddy/views to the view_path" do
          path = File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "rails-caddy", "views"))
          assert ActionController::Base.view_paths.include?(path)
        end
        
        should "require (and ultimately define) RailsCaddyController"

      end
      
    end
    
  end
  
end
