# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails-caddy}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Trupiano"]
  s.date = %q{2009-04-19}
  s.email = %q{jtrupiano@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/rails-caddy", "lib/rails-caddy/controllers", "lib/rails-caddy/controllers/rails_caddy_controller.rb", "lib/rails-caddy/controllers/sanitize_email_controller.rb", "lib/rails-caddy/controllers/session_editing_controller.rb", "lib/rails-caddy/controllers/timecop_controller.rb", "lib/rails-caddy/errors.rb", "lib/rails-caddy/helpers", "lib/rails-caddy/helpers/rails_caddy_helper.rb", "lib/rails-caddy/session_controller_finder.rb", "lib/rails-caddy/views", "lib/rails-caddy/views/_rails_caddy.html.erb", "lib/rails-caddy/views/_rails_caddy_css.html.erb", "lib/rails-caddy/views/_rails_caddy_js.html.erb", "lib/rails-caddy.rb", "test/files", "test/files/acet.rb", "test/files/fct.rb", "test/files/rcct.rb", "test/files/sanitize_email_action_controller_extensions_test_methods.rb", "test/files/sanitize_email_controller_test_methods.rb", "test/files/session_editing_controller_test_methods.rb", "test/files/timecop_action_controller_extensions_test_methods.rb", "test/files/timecop_controller_test_methods.rb", "test/geminstaller.yml", "test/rails", "test/rails_caddy_controller_test.rb", "test/rails_caddy_helper_test.rb", "test/rails_caddy_test.rb", "test/rails_modifier.rb", "test/README.txt", "test/routes.rb", "test/session_controller_finder_test.rb", "test/test_helper.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jtrupiano/rails-caddy}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<timecop>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<sanitize_email>, ["~> 0.1.0"])
    else
      s.add_dependency(%q<timecop>, ["~> 0.2.0"])
      s.add_dependency(%q<sanitize_email>, ["~> 0.1.0"])
    end
  else
    s.add_dependency(%q<timecop>, ["~> 0.2.0"])
    s.add_dependency(%q<sanitize_email>, ["~> 0.1.0"])
  end
end
