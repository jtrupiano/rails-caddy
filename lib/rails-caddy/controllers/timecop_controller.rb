module TimecopController
  
  def self.included(base)
    base.class_eval do
      # Make sure we don't reset our own time!
      skip_filter :handle_timecop_offset
    end
    base.send(:include, Actions)
  end

  module Actions
    def timecop_update
      year, month, day, hour, min, sec = params[:year], params[:month], params[:day], params[:hour], params[:min], params[:sec]
      session[:timecop_adjusted_time] = Time.local(year, month, day, hour, min, sec)
      render :status => 200, :nothing => true
    end
  
    def timecop_reset
      session[:timecop_adjusted_time] = nil
      render :status => 200, :nothing => true
    end
  end
  
end
