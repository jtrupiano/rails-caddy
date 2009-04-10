require 'test_helper'
require 'timecop'
require 'files/common_rails_caddy_tests'

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
    
    include CommonRailsCaddyTests
    
  end
  
end