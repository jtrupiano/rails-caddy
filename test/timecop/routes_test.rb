require 'test_helper'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'
require 'action_controller/assertions/routing_assertions'

class RoutesTest < Test::Unit::TestCase
  include ActionController::Assertions::RoutingAssertions

  context "Routes have been loaded" do
  
    setup do
      require "rails-caddy/timecop/routes"
      def clean_backtrace; end
    end
  
    should "recognize route update_time_path" do
      assert_recognizes({:controller => 'timecop', :action => 'update'}, '/timecop/update')
    end
  
    should "recognize route reset_time_path" do
      assert_recognizes({:controller => 'timecop', :action => 'reset'}, '/timecop/reset')      
    end
  end
  
end