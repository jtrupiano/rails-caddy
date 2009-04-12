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
                
        should "set :sanitize_email_address session variable when #set_sanitize_email_address is invoked" do
          post :set_sanitize_email_address, :value => "jtrupiano@gmail.com"
          assert_response :success
          assert_equal "jtrupiano@gmail.com", @response.body
          assert_equal "jtrupiano@gmail.com", session[:sanitize_email_address]
        end
        
        should "unset :sanitize_email_address session variable when #unset_sanitize_email_address is invoked" do
          post :unset_sanitize_email_address
          assert_response :success
          assert_equal "nil", @response.body
          assert_nil session[:sanitize_email_address]
        end
      end
    end
  end
end