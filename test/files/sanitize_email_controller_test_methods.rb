module SanitizeEmailControllerTestMethods
  
  def self.included(base)
    base.class_eval do
      context "When the SanitizeEmailController module has been included" do

        should "send email as intended when :sanitized_email_address session variable is not set"
        
        should "interpret the :sanitized_email_address session variable when set"
        
        should "set :sanitized_email_address session variable when #set_sanitized_email_address is invoked"
        
        should "unset :sanitized_email_address session variable when #unset_sanitized_email_address is invoked"
      end
    end
  end
end