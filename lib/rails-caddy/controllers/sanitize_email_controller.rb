module SanitizeEmailController
  
  def self.included(base)
    base.send(:include, Actions)
  end

  module Actions
  
    def set_sanitize_email_address
      session[:sanitize_email_address] = params[:value]
      render :status => 200, :text => params[:value]
    end
  
    def unset_sanitize_email_address
      session[:sanitize_email_address] = nil
      render :status => 200, :text => "nil"
    end
  end
  
  module ActionControllerExtensions
    # def self.included(base)
    #   base.class_eval do
    #     around_filter :handle_sanitize_email
    #   end
    # end
    
    def handle_sanitize_email
      if session[:sanitize_email_address].nil?
        yield
        return
      end
      
      @original_sanitized_recipients = ActionMailer::Base.sanitized_recipients
      ActionMailer::Base.sanitized_recipients = session[:sanitize_email_address]
      yield
    ensure
      ActionMailer::Base.sanitized_recipients = @original_sanitized_recipients
    end
    
    private :handle_sanitize_email
  end
end