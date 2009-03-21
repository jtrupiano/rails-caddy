require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

require 'rails-caddy/session_controller_finder'

class SessionControllerFinderTest < Test::Unit::TestCase
  
  context "ApplicationController has yet to be defined" do

    setup do
      Object.send(:remove_const, :ApplicationController) if Object.const_defined?(:ApplicationController)
    end
    
    should "raise NameError when accessing ApplicationController" do
      assert_raise(NameError) { ApplicationController }
    end
  
    should "raise RailsCaddy::SessionControllerNotFoundError when searching" do
      assert_raise(RailsCaddy::SessionControllerNotFoundError) { SessionControllerFinder.find }
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

        should "raise SessionUninitializedError when calling #find" do
          assert_raise(RailsCaddy::SessionUninitializedError) { SessionControllerFinder.find }
        end
      end
      
      context "session has been initialized, and a key set" do
        setup do
          ::ApplicationController.session_options[:key] = "blah"
        end

        should "not return ApplicationController when calling #find" do
          assert_equal ::ApplicationController, SessionControllerFinder.find
        end

      end
    
    end
  end

end  
