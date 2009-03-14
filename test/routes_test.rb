require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'
require 'action_controller/assertions/routing_assertions'

class RoutesTest < Test::Unit::TestCase
  include ActionController::Assertions::RoutingAssertions

  context "Routes have been loaded" do
  
    setup do
      require "rails-caddy/routes"
      def clean_backtrace; end
    end
  
    should "recognize route timecop_update_path" do
      assert_recognizes({:controller => 'rails-caddy', :action => 'update'}, '/rails-caddy/timecop_update')
    end
  
    should "recognize route timecop_reset_path" do
      assert_recognizes({:controller => 'rails-caddy', :action => 'reset'}, '/rails-caddy/timecop_reset')      
    end
  end
  
end