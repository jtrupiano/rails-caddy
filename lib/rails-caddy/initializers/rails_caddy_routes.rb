# For pre-rails 2.3.x
module ActionController
  module Routing #:nodoc:
    class RouteSet #:nodoc:
      alias_method :draw_without_rails_caddy_routes, :draw

      def draw
        draw_without_rails_caddy_routes do |map|
          RailsCaddy.define_routes!(map)
          
          yield map if block_given?
        end
      end
    end
  end
end