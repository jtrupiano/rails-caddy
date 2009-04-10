require File.join(File.dirname(__FILE__), '..', 'test_helper')

class FrogsControllerTest < ActionController::TestCase  
  def test_should_render_rails_caddy_on_index_with_empty_session
    get :index
    assert_response :success
    assert_template 'index'
  end
  
  def test_should_render_entries_for_each_key_in_the_session
    sess = {"key1" => "abc", "key2" => "def"}
    get :index, {}, sess
    assert_response :success
    assert_template 'index'
    assert_outputs_session_vars(sess.keys)
  end
  
  def test_should_render_newly_created_session_variable
    # Recall that hitting /abc sets the 'something' session variable to 'abc'
    sess = {"key1" => "abc", "key2" => "def"}
    get :abc, {}, sess
    assert_response :success
    assert_template 'index'
    assert_outputs_session_vars(sess.keys + ["something"])
  end
  
  private
    def assert_outputs_session_vars(keys)
      keys.each do |key|
        # ugly regexp...
        regex = Regexp.new("sessionVariableEditor\\(\\\"#{key}\\\"")
        assert_match regex, @response.body
      end
    end
end
