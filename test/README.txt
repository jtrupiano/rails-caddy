## Steps to build a new baseline app in a separate rails version for testing

rails _VERSION_ testVERSION

ruby script/generate controller frogs index

rake db:migrate

edit frogs_controller, add:
  %w(abc def ghi).each do |action|
    define_method(action) do
      session[:something] = action
      render :action => 'index'
    end
  end

edit frogs/index.html.erb
  <html>
  <head>
    <title>Test</title>
    <%= javascript_include_tag :all %>
  </head>
  <body>
    <% if ["staging", "development"].include?(RAILS_ENV) -%>
      <%= rails_caddy %>
    <% end -%>
  </body>
  </html>

edit application.rb
  helper RailsCaddyHelper if %w(development staging).include? RAILS_ENV
  layout nil
  
edit environment.rb
  config.gem "rails-caddy"
  
  require 'rails-caddy'
  require_dependency 'application'
  RailsCaddy.init!
  