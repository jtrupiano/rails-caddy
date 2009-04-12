require 'test_helper'
require 'timecop'
require 'files/common_rails_caddy_tests'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

# Fake an ApplicationController
class ApplicationController < ActionController::Base
  session_options[:key] = "blah"
end

# Define RailsCaddyController
RailsCaddy.init!
require 'routes'

class RailsCaddyControllerTest < ActionController::TestCase
  tests RailsCaddyController
  
  context "RailsCaddy has been initialized" do
    
    should "include TimecopController" do
      assert RailsCaddyController.included_modules.include?(TimecopController)
    end

    should "include SessionEditingController" do
      assert RailsCaddyController.included_modules.include?(SessionEditingController)
    end
    
    should "include SanitizeEmailController" do
      assert RailsCaddyController.included_modules.include?(SanitizeEmailController)
    end
    
    include CommonRailsCaddyTests
    
  end
  
end