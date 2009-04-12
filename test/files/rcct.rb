require File.join(File.dirname(__FILE__), '..', 'test_helper')
require 'shoulda'
require File.join(File.dirname(__FILE__), '..', 'session_editing_controller_test_methods')
require File.join(File.dirname(__FILE__), '..', 'timecop_controller_test_methods')
require File.join(File.dirname(__FILE__), '..', 'sanitize_email_controller_test_methods')

class RailsCaddyControllerTest < ActionController::TestCase
  
  include SessionEditingControllerTestMethods
  include TimecopControllerTestMethods
  include SanitizeEmailControllerTestMethods
  
end
