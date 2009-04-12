require 'files/session_editing_controller_test_methods'
require 'files/timecop_controller_test_methods'
require 'files/sanitize_email_controller_test_methods'

module CommonRailsCaddyTests
  
  def self.included(base)
    base.class_eval do    
      include SessionEditingControllerTestMethods
      include TimecopControllerTestMethods
      include SanitizeEmailControllerTestMethods
    end
  end
end