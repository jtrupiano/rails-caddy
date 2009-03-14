module ActionController
  module Routing #:nodoc:
    class RouteSet #:nodoc:
      alias_method :draw_without_rails_caddy_routes, :draw
      def draw
        draw_without_rails_caddy_routes do |map|

          # Timecop routes
          map.update_time '/rails-caddy/timecop_update', :controller => 'rails-caddy', :action => 'timecop_update'
          map.reset_time '/rails-caddy/timecop_reset', :controller => 'rails-caddy', :action => 'timecop_reset'

          yield map if block_given?
        end
      end
    end
  end
end
