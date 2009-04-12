# Becomes test/functional/action_controller_extensions_test.rb in rails apps.  Tests that our extensions to ActionController::Base work 
# in combination.

require File.join(File.dirname(__FILE__), '..', 'test_helper')
require 'shoulda'
require 'rr'
require File.join(File.dirname(__FILE__), '..', 'timecop_action_controller_extensions_test_methods')
require File.join(File.dirname(__FILE__), '..', 'sanitize_email_action_controller_extensions_test_methods')

class Test::Unit::TestCase
  include RR::Adapters::TestUnit unless include?(RR::Adapters::TestUnit)
end

require 'rails-caddy'
RailsCaddy.init!

class DummyMailer < ActionMailer::Base
  def test_email
    recipients "nobody@smartlogicsolutions.com"
    @subject = "A Title"
    @body = "some dummy content"
  end
end

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.local_environments = ["test"]

class TestController < ActionController::Base
  # Simply a helper for us
  def self.around_filters
    self.filter_chain.select {|filter| filter.class == ActionController::Filters::AroundFilter}.map(&:method)
  end
end

class ActionControllerExtensionsTest < Test::Unit::TestCase
  
  include TimecopActionControllerExtensionsTestMethods
  include SanitizeEmailActionControllerExtensionsTestMethods
      
end
