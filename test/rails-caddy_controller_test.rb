require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

require 'timecop'
require "rails-caddy/timecop/controller_methods"

class RailsCaddyControllerTest < ActionController::TestCase

  # context "Session has been activated in ApplicationController" do
  #   should "raise exception when loading RailsCaddyController" do
  #     assert_raise(NameError) { require 'rails-caddy/controllers/rails-caddy_controller' }
  #   end
  # end
  # 
  # context "Session has been activated in ApplicationController" do
  # 
  #   setup do
  #     require 'sample_application_controller'
  #   end
  #   
  #   should "not raise exception when loading RailsCaddyController" do
  #     assert_nothing_raised { require 'rails-caddy/controllers/rails-caddy_controller' }
  #   end
  # end
  
end