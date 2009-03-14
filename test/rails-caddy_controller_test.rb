require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

require 'timecop'

class ApplicationController < ActionController::Base; end

class RailsCaddyControllerTest < ActionController::TestCase

  context "RailsCaddy has been initialized" do
    
    setup do
      stub(ApplicationController).session { [{:session_key => "blah"}] }
      RailsCaddy.init!
    end
    
    should "recognize RailsCaddyController constant" do
      assert Object.const_defined?(:RailsCaddyController)
    end
    
    # context ""
    # should "respond to #timecop_update" do
    #   assert 
    
  end
  
end