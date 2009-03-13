require 'test_helper'
require 'rails-caddy'

class RailsCaddyTest < Test::Unit::TestCase
  
  context "ApplicationController has not been defined" do
    
    setup do
      # There's no guarantee which order these are run in, so we'll just remove it from the ObjectSpace altogether
      Object.send(:remove_const, :ApplicationController) if Object.const_defined?(:ApplicationController)
    end
    
    should "raise exception when initializing RailsCaddy" do
      assert_raise(SessionControllerNotFoundError) { RailsCaddy.init! }
    end
  end
  
  context "ApplicationController has been defined" do
  
    setup do
      class ::ApplicationController < ActionController::Base; end
    end
    
    context "session has not been initialized" do
      setup do
        ::ApplicationController.class_eval do
          session nil
        end
      end
      
      should "raise SessionUninitializedError when initializing RailsCaddy" do
        assert_raise(SessionUninitializedError) { RailsCaddy.init! }
      end
    end
    
    context "session has been initialized" do
      setup do
        ::ApplicationController.class_eval do
          session :session_key => 'blah'
        end
      end
      
      should "not raise exception when initializing RailsCaddy" do
        assert_nothing_raised { RailsCaddy.init! }
      end
      
    end
    
  end
  
end
