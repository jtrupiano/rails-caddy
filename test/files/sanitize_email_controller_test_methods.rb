module SanitizeEmailControllerTestMethods
  
  def self.included(base)
    base.class_eval do
      context "When the SanitizeEmailController module has been included" do
        
        should "recognize route set_sanitize_email_address_path" do
          assert_recognizes({:controller => 'rails_caddy', :action => 'set_sanitize_email_address'}, '/rails_caddy/set_sanitize_email_address')
        end

        should "recognize route unset_sanitize_email_address_path" do
          assert_recognizes({:controller => 'rails_caddy', :action => 'unset_sanitize_email_address'}, '/rails_caddy/unset_sanitize_email_address')
        end
        
        should "send email as intended when :sanitize_email_address session variable is not set"
        
        should "interpret the :sanitize_email_address session variable when set"
        
        should "set :sanitize_email_address session variable when #set_sanitize_email_address is invoked"
        
        should "unset :sanitize_email_address session variable when #unset_sanitize_email_address is invoked"
      end
    end
  end
end