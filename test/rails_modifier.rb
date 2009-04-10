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
      append("  config.gem 'rails-caddy'", "Rails::Initializer.run do |config|", "config/environment.rb")
      write("config/environment.rb", File.readlines("config/environment.rb").join + "\n" + environment_rb(version))
      
      # Copy over tests
      FileUtils::cp(file_path("common_rails_caddy_tests.rb"), File.join("test", "common_rails_caddy_tests.rb"))
      FileUtils::cp(file_path("rcct.rb"), File.join("test", "functional", "rails_caddy_controller_test.rb"))
      FileUtils::cp(file_path("fct.rb"),  File.join("test", "functional", "frogs_controller_test.rb"))
      
      unless version =~ /^2\.3\./
        append("require 'rails-caddy/tasks'", nil,  'Rakefile')
        `rake caddy:routes:install`
      end
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
  <% if %w(development staging test).include?(RAILS_ENV) -%>
    <%= rails_caddy %>
  <% end -%>
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
  helper RailsCaddyHelper if %w(development staging test).include? RAILS_ENV
  layout nil
        RUBY
      end
    
      def environment_rb(version)
        <<-RUBY
require 'rails-caddy'
require_dependency '#{application_rb_require(version)}'
RailsCaddy.init!
        RUBY
      end
  end
end