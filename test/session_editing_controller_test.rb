require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

# Create RailsCaddyController, and test against it.
class ApplicationController < ActionController::Base; end
RailsCaddy.init!
require 'routes' # load in the RailsCaddy routes

require 'files/session_editing_controller_test_methods'

class SessionEditingControllerTest < ActionController::TestCase
  tests RailsCaddyController
  
  context "RailsCaddy has been initialized" do
    include SessionEditingControllerTestMethods
  end
  
end