require 'test_helper'

# We need ActionPack loaded to test this out
require 'activesupport'
require 'actionpack'
require 'action_controller'
require 'action_view/test_case'

# Fake an ApplicationController
class ApplicationController < ActionController::Base
  session_options[:key] = "blah"
end

# Define RailsCaddyController
RailsCaddy.init!

class RailsCaddyHelperTest < ActionView::TestCase
  def test_rc_in_place_editor_field
    html = rc_in_place_editor_field("user_id", 1)
    assert_match /rails_caddy_user_id_in_place_editor/, html
    # very hacky, but I'm just trying to verify that the value 1 was placed inside the span tag (of the in place edit)
    assert_match />1<\/span>/, html
  end
end