module SessionEditingControllerTestMethods
  
  def self.included(base)
    base.class_eval do
      context "When the SessionEditingController module has been included" do

        should "recognize route update_session_path" do
          assert_recognizes({:controller => 'rails_caddy', :action => 'update_session', :id => 'foo'}, '/rails_caddy/update_session/foo')
        end

        should "recognize route remove_session_path" do
          assert_recognizes({:controller => 'rails_caddy', :action => 'remove_session', :id => 'foo'}, '/rails_caddy/remove_session/foo')
        end

        should "be able to update an existing session variable" do
          post(:update_session, {:id => "username", :value => "joe"}, {:username => "john"})
          assert_response 200
          assert_equal "joe", session[:username]
        end

        should "be able to add a new session variable" do
          post(:update_session, {:id => "name", :value => "jason"})
          assert_response 200
          assert_equal "jason", session[:name]
        end

        should "render 422 when session variable id is missing" do
          post(:update_session, {})
          assert_response 422
        end

        should "be able to remove an existing session variable" do
          post(:remove_session, {:id => "username"}, {:username => "john"})
          assert_response 200
          assert_equal nil, session[:username]
        end

      end
    end
  end
end