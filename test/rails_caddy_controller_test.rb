require 'test_helper'
require 'timecop'

# We need ActionPack loaded to test this out
require 'actionpack'
require 'action_controller'

# def print_routes
#   routes = ActionController::Routing::Routes.routes.collect do |route|
#     name = ActionController::Routing::Routes.named_routes.routes.index(route).to_s
#     verb = route.conditions[:method].to_s.upcase
#     segs = route.segments.inject("") { |str,s| str << s.to_s }
#     segs.chop! if segs.length > 1
#     reqs = route.requirements.empty? ? "" : route.requirements.inspect
#     {:name => name, :verb => verb, :segs => segs, :reqs => reqs}
#   end
#   name_width = routes.collect {|r| r[:name]}.collect {|n| n.length}.max
#   verb_width = routes.collect {|r| r[:verb]}.collect {|v| v.length}.max
#   segs_width = routes.collect {|r| r[:segs]}.collect {|s| s.length}.max
#   routes.each do |r|
#     puts "#{r[:name].rjust(name_width)} #{r[:verb].ljust(verb_width)} #{r[:segs].ljust(segs_width)} #{r[:reqs]}"
#   end
#   puts "************** DONE OUTPUTTING"
# end


# Fake an ApplicationController
class ApplicationController < ActionController::Base
  session_options[:key] = "blah"
end

# Define RailsCaddyController
RailsCaddy.init!

class RailsCaddyControllerTest < ActionController::TestCase
  tests RailsCaddyController
  
  context "RailsCaddy has been initialized" do
    
    should "include TimecopController" do
      assert RailsCaddyController.included_modules.include?(TimecopController)
    end

    should "include SessionEditingController" do
      assert RailsCaddyController.included_modules.include?(SessionEditingController)
    end
    
    should "have defined update_session as an instance method" do
      assert RailsCaddyController.instance_methods.include?("update_session")
    end
    
    should "recognize route timecop_update_path" do
      assert_recognizes({:controller => 'rails_caddy', :action => 'timecop_update'}, '/rails_caddy/timecop_update')
    end
  
    should "recognize route timecop_reset_path" do
      assert_recognizes({:controller => 'rails_caddy', :action => 'timecop_reset'}, '/rails_caddy/timecop_reset')      
    end
    
    should "recognize route update_session_path" do
      assert_recognizes({:controller => 'rails_caddy', :action => 'update_session', :id => 'foo'}, '/rails_caddy/update_session/foo')
    end
    
    should "recognize route remove_session_path" do
      assert_recognizes({:controller => 'rails_caddy', :action => 'remove_session', :id => 'foo'}, '/rails_caddy/remove_session/foo')
    end
    
    should "respond to #timecop_update" do
      post :timecop_update, {:year => 2008, :month => 12, :day => 1}
      assert_response :success
      assert_equal Time.local(2008, 12, 1), session[:timecop_adjusted_time]
    end
    
    should "respond to #timecop_reset" do
      post :timecop_reset
      assert_response :success
      assert_equal nil, session[:timecop_adjusted_time]      
    end
    
    should "respond to #update_session" do
      assert_not_equal session[:foo], "bar"
      post :update_session, {:id => "foo", :value => "bar"}
      assert_response :success
      assert_equal "bar", session[:foo]
    end
    
  end
  
end