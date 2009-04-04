require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

# Create RailsCaddyController, and test against it.
class ApplicationController < ActionController::Base; end
RailsCaddy.init!

class SessionEditingControllerTest < ActionController::TestCase
  tests RailsCaddyController
  
  context "When the SessionEditingController module has been included into MyController" do
    
    should "be able to update an existing session variable" do
      post(:update_session, {:id => "username", :value => "joe"}, {:username => "john"})
      assert_response 200
      assert_equal "joe", session[:username]
    end
    
    should "be able to add a new session variable" do
      post(:update_session, {:id => "name", :value => "jason"})
      assert_response 200
      assert_equal "jason", session[:name]
    end
    
    should "render 422 when session variable id is missing" do
      post(:update_session, {})
      assert_response 422
    end
    
    should "be able to remove an existing session variable" do
      post(:remove_session, {:id => "username"}, {:username => "john"})
      assert_response 200
      assert_equal nil, session[:username]
    end
    
  end
end