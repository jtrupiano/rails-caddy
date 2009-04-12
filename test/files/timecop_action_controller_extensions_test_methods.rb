module TimecopActionControllerExtensionsTestMethods
  
  def self.included(base)
    base.class_eval do
      context "TestController has been extended by TimecopController::ActionControllerExtensions" do
        setup do
          @controller = TestController.new
        end

        should "add :handle_timecop_offset as an around_filter" do
          assert @controller.class.around_filters.include?(:handle_timecop_offset)
        end

        context "session has been set" do
          setup do
            @travel_to = Time.local(2009, 1, 1)
            @session_stub = {:timecop_adjusted_time => @travel_to}

            stub(@controller).session { @session_stub }
          end

          should "adjust time" do
            @controller.send(:handle_timecop_offset) do
              assert_not_nil Time.now
              assert (@travel_to - Time.now).abs < 100 # 100ms should be plenty of time for this test to run
              # Brittle --> totally dependent upon implementation details of Timecop
              assert (Time.now_without_mock_time - Time.now) > 5.days # We're well past Jan. 1, 2009, so this should be safe
            end
          end

          should "move time forward by 3 seconds after yielding to consuming controller action" do
            @controller.send(:handle_timecop_offset) do; end
            # I can't do a straight assert_equal for some reason...
            assert (@travel_to + 3 - @controller.session[:timecop_adjusted_time]).abs < 1
          end
        end

        context "session has not been set" do
          setup do
            stub(@controller).session { {} }
          end

          should "not adjust time" do
            @controller.send(:handle_timecop_offset) do
              assert_not_nil Time.now
              # Brittle --> totally dependent upon implementation details of Timecop
              assert (Time.now_without_mock_time - Time.now) < 10 # shouldn't take more than 10ms to execute
            end
          end
        end
      end
      
    end
  end
end