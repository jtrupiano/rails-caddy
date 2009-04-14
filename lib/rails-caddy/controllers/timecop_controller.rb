module TimecopController
  
  def self.included(base)
    # base.class_eval do
    #   # Make sure we don't reset our own time!
    #   skip_filter :handle_timecop_offset
    # end
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
  
  module ActionControllerExtensions
    # def self.included(base)
    #   base.class_eval do
    #     around_filter :handle_timecop_offset
    #   end
    # end

    # to be used as an around_filter
    def handle_timecop_offset
      # Establish now
      if !session[:timecop_adjusted_time].nil?
        #puts "***** Time traveling to #{session[:timecop_adjusted_time].to_s}"
        Timecop.travel(session[:timecop_adjusted_time])
      else
        Timecop.return
      end

      # Run the intended action
      yield

      # we want to continue to slide time forward, even if it's only 3 seconds at a time.
      # this ensures that subsequent calls during the same "time travel" actually pass time
      if !session[:timecop_adjusted_time].nil?
        #puts "====== Resetting session to: #{Time.now + 3}"
        session[:timecop_adjusted_time] = Time.now + 3 # slide it forward a couple of seconds
      end
    end

    private :handle_timecop_offset
    
  end
  
end
