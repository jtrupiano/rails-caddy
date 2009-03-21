require 'rake'
require 'fileutils'

namespace :caddy do
  namespace :routes do
    desc "Blindly write config/initializers/rails_caddy_routes.rb.  Provides necessary pre-rails 2.3.0 routing hooks for rails-caddy to function properly."
    task :install do
      from = File.expand_path(File.join(File.dirname(__FILE__), 'initializers', 'rails_caddy_routes.rb'))
      to   = File.expand_path(File.join(RAILS_ROOT, 'config', 'initializers', 'rails_caddy_routes.rb'))
      FileUtils::cp from, to
      puts "Created config/initializers/rails_caddy_routes.rb"
    end
  end
end