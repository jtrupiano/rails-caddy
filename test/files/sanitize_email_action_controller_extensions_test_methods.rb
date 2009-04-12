module SanitizeEmailActionControllerExtensionsTestMethods
  
  def self.included(base)
    base.class_eval do
      context "TestController has been extended by SanitizeEmailController::ActionControllerExtensions" do
        setup do
          @controller = TestController.new
        end

        should "add :handle_sanitize_email as an around_filter" do
          assert @controller.class.around_filters.include?(:handle_sanitize_email)
        end
        
        context "ActionMailer::Base.sanitized_recipients has been set in config/environment.rb" do
          
          setup do
            @default_sanitized_email = "jtrupiano@gmail.com"
            ActionMailer::Base.sanitized_recipients = @default_sanitized_email
          end
          
          context "session[:sanitize_email_address] has been set and :handle_sanitize_email is invoked" do
            setup do
              @sanitize_email = "john@smartlogicsolutions.com"
              @session_stub = {:sanitize_email_address => @sanitize_email}

              stub(@controller).session { @session_stub }
            end

            should "set ActionMailer::Base.sanitized_recipients" do
              @controller.send(:handle_sanitize_email) do
                assert_not_nil ActionMailer::Base.sanitized_recipients
                assert_equal @sanitize_email, ActionMailer::Base.sanitized_recipients
              end
            end

            should "reroute generated emails as per session[:sanitize_email_address]" do
              @controller.send(:handle_sanitize_email) do
                mail = DummyMailer.create_test_email
                assert_equal [@sanitize_email], mail.to
              end
            end
          end

          context "session[:sanitize_email_address] has not been set and :handle_sanitize_email is invoked" do
            setup do
              stub(@controller).session { {} }
            end

            should "not set ActionMailer::Base.sanitized_recipients" do
              @controller.send(:handle_sanitize_email) do
                assert_equal @default_sanitized_email, ActionMailer::Base.sanitized_recipients
                # assert_nil ActionMailer::Base.sanitized_cc
                # assert_nil ActionMailer::Base.sanitized_bcc
              end
            end

            should "not reroute generated emails" do
              @controller.send(:handle_sanitize_email) do
                mail = DummyMailer.create_test_email
                assert_equal [@default_sanitized_email], mail.to
              end
            end
          end
          
        end

      end

    end
  end
end