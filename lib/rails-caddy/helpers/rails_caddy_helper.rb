module RailsCaddyHelper
  # actually embeds the magic that is the Rails Caddy
  def rails_caddy
    render(:partial => '/rails_caddy')
  end
  
  def translated_remove_session_path
    url = remove_session_path
    url << "/" unless url.match(/\/$/)
  end
  
  def rc_in_place_editor(key, field_id, url)
    function =  "RailsCaddy.editors['" + key + "'] = new Ajax.InPlaceEditor("
    function << "'#{field_id}', "
    function << "'#{url}'"
    function << ');'

    javascript_tag(function)
  end
  
  def rc_in_place_editor_field(key, value)
    tag = ::ActionView::Helpers::InstanceTag.new("rails_caddy", key, self)
    tag_options = {:tag => "span", :id => "rails_caddy_#{key}_in_place_editor", :name => "value", :class => "in_place_editor_field"}
    
    # rails < 2.3 needs to be treated with kid gloves.
    url = update_session_path
    url << "/" unless url.match(/\/$/)
    url << key
    
    tag.content_tag(tag_options.delete(:tag), value, tag_options) + rc_in_place_editor(key, tag_options[:id], url)
  end
  
end