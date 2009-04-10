require File.join(File.dirname(__FILE__), '..', 'test_helper')
require 'shoulda'
require File.join(File.dirname(__FILE__), '..', 'common_rails_caddy_tests')

class RailsCaddyControllerTest < ActionController::TestCase
  
  include CommonRailsCaddyTests
  
end
