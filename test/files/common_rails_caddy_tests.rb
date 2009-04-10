module CommonRailsCaddyTests
  
  def self.included(base)
    base.class_eval do
      
      should "recognize route timecop_update_path" do
        assert_recognizes({:controller => 'rails_caddy', :action => 'timecop_update'}, '/rails_caddy/timecop_update')
      end

      should "recognize route timecop_reset_path" do
        assert_recognizes({:controller => 'rails_caddy', :action => 'timecop_reset'}, '/rails_caddy/timecop_reset')      
      end
  
      should "recognize route update_session_path" do
        assert_recognizes({:controller => 'rails_caddy', :action => 'update_session', :id => 'foo'}, '/rails_caddy/update_session/foo')
      end
  
      should "recognize route remove_session_path" do
        assert_recognizes({:controller => 'rails_caddy', :action => 'remove_session', :id => 'foo'}, '/rails_caddy/remove_session/foo')
      end
  
      should "respond to #timecop_update" do
        post :timecop_update, {:year => 2008, :month => 12, :day => 1}
        assert_response :success
        assert_equal Time.local(2008, 12, 1), session[:timecop_adjusted_time]
      end
  
      should "respond to #timecop_reset" do
        post :timecop_reset
        assert_response :success
        assert_equal nil, session[:timecop_adjusted_time]      
      end
  
      should "respond to #update_session" do
        post :update_session, {:id => "foo", :value => "bar"}
        assert_response :success
        assert_equal "bar", session[:foo]
      end
  
      should "respond to #remove_session" do
        post :remove_session, {:id => "foo", :value => "bar"}, {:foo => "something defined"}
        assert_response :success
        assert_nil session[:foo]    
      end
    end
  end
end