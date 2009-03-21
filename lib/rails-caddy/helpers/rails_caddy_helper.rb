module RailsCaddyHelper
  # actually embeds the magic that is the Rails Caddy
  def rails_caddy
    render(:partial => '/rails_caddy')
  end
end