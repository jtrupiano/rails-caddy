ActionController::Routing::Routes.draw do |map|
  # Timecop routes
  map.timecop_update '/rails_caddy/timecop_update', :controller => 'rails_caddy', :action => 'timecop_update'
  map.timecop_reset '/rails_caddy/timecop_reset', :controller => 'rails_caddy', :action => 'timecop_reset'
end

# module ActionController
#   module Routing #:nodoc:
#     class RouteSet #:nodoc:
#       alias_method :draw_without_rails_caddy_routes, :draw
#       def draw
#         draw_without_rails_caddy_routes do |map|
#           raise 'wtf'
#           # Timecop routes
#           map.timecop_update '/rails_caddy/timecop_update', :controller => 'rails_caddy', :action => 'timecop_update'
#           map.timecop_reset '/rails_caddy/timecop_reset', :controller => 'rails_caddy', :action => 'timecop_reset'
# 
#           yield map if block_given?
#         end
#       end
#     end
#   end
# end
