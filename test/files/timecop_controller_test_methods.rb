module TimecopControllerTestMethods
  
  def self.included(base)
    base.class_eval do
      context "When the TimecopController module has been included" do

        should "recognize route timecop_update_path" do
          assert_recognizes({:controller => 'rails_caddy', :action => 'timecop_update'}, '/rails_caddy/timecop_update')
        end

        should "recognize route timecop_reset_path" do
          assert_recognizes({:controller => 'rails_caddy', :action => 'timecop_reset'}, '/rails_caddy/timecop_reset')      
        end

        should "update time when a valid year/month/day are passed into #timecop_update" do
          post :timecop_update, {:year => 2008, :month => 12, :day => 1}
          assert_response :success
          assert_equal Time.local(2008, 12, 1), session[:timecop_adjusted_time]
        end

        should "unset :timecop_adjusted_time when #timecop_reset action is invoked" do
          post :timecop_reset, {}, {:timecop_adjusted_time => Time.local(2008, 4, 4)}
          assert_response :success
          assert_equal nil, session[:timecop_adjusted_time]      
        end
        
      end
    end
  end
end