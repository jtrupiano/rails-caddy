require 'fileutils'

class RailsModifier
  
  class << self
    def modify!(version)
      `ruby script/generate controller frogs index`
      `rake db:migrate`
      # prepend these actions before the def index that is generated...
      prepend(frog_actions, "def index", 'app/controllers/frogs_controller.rb')
      write('app/views/frogs/index.html.erb', frogs_index_html_erb)
      prepend(application_rb, "end", application_controller(version))
      replace("config.time_zone = 'UTC'", "", "config/environment.rb")
      append(test_config_rb(version), nil, "config/environments/test.rb")
      append(routes_rb, "ActionController::Routing::Routes.draw do |map|", "config/routes.rb")
      
      # Copy over tests
      %w(session_editing_controller timecop_controller timecop_action_controller_extensions sanitize_email_controller sanitize_email_action_controller_extensions).each do |file_prefix|
        FileUtils::cp(file_path("#{file_prefix}_test_methods.rb"), File.join("test", "#{file_prefix}_test_methods.rb"))
      end
      FileUtils::cp(file_path("rcct.rb"), File.join("test", "functional", "rails_caddy_controller_test.rb"))
      FileUtils::cp(file_path("fct.rb"),  File.join("test", "functional", "frogs_controller_test.rb"))
      FileUtils::cp(file_path("acet.rb"),  File.join("test", "functional", "action_controller_extensions_test.rb"))
    end

    private
      def prepend(content, before_string, filename)
        file_contents = File.readlines(filename).join
        write(filename, file_contents.gsub(before_string, content + "\n" + before_string))
      end
      
      def append(content, after_string, filename)
        file_contents = File.readlines(filename).join
        new_contents = if after_string.nil?
          file_contents + "\n" + content
        else
          file_contents.gsub(after_string, after_string + "\n" + content)
        end
        write(filename, new_contents)
      end
      
      def replace(original_content, new_content, filename)
        file_contents = File.readlines(filename).join
        write(filename, file_contents.gsub(original_content, new_content))
      end
    
      def write(filename, content)
        File.open(filename, 'w') do |f|
          f.write(content)
        end
      end
      
      def file_path(filename)
        File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "files", filename))
      end
    
      def frog_actions
        <<-RUBY
  %w(abc def ghi).each do |action|
    define_method(action) do
      session[:something] = action
      render :action => 'index'
    end
  end
  
        RUBY
      end
  
      def frogs_index_html_erb
        <<-ERB
<html>
<head>
  <title>Test</title>
  <%= javascript_include_tag :all %>
</head>
<body>
  <%= rails_caddy if Object.const_defined?(:RailsCaddy) %>
</body>
</html>
        ERB
      end
  
      def application_rb_require(version)
        version == "2.3.2" ? "application_controller" : "application"
      end
    
      def application_controller(version)
        "app/controllers/#{application_rb_require(version)}.rb"
      end
  
      def application_rb
        <<-RUBY
  helper RailsCaddyHelper if Object.const_defined?(:RailsCaddy)
  layout nil
        RUBY
      end
      
      def test_config_rb(version)
        <<-RUBY
config.gem 'rails-caddy'

config.after_initialize do
  require 'rails-caddy'
  require_dependency '#{application_rb_require(version)}'
  RailsCaddy.init!  
end
        RUBY
      end
      
      def routes_rb
        <<-RUBY
  RailsCaddy.define_routes!(map) if Object.const_defined?(:RailsCaddy)
  #map.resources :frogs, :only => [:index], :member => [:abc, :def, :ghi]
        RUBY
      end
  end
end