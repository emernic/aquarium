# -*- encoding: utf-8 -*-
# stub: flot-rails 0.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "flot-rails".freeze
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vasily Fedoseyev".freeze]
  s.date = "2014-04-24"
  s.description = "Provides easy installation and usage of jQuery-flot javascript library for your Rails 3.1+ application.".freeze
  s.email = ["vasilyfedoseyev@gmail.com".freeze]
  s.homepage = "http://rubygems.org/gems/flot-rails".freeze
  s.rubygems_version = "2.6.12".freeze
  s.summary = "jQuery Flot for Rails Asset pipeline".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jquery-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, ["~> 3.1"])
    else
      s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, ["~> 3.1"])
    end
  else
    s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, ["~> 3.1"])
  end
end
