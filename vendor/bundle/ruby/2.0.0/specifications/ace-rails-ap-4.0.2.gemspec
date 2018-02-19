# -*- encoding: utf-8 -*-
# stub: ace-rails-ap 4.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ace-rails-ap".freeze
  s.version = "4.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Cody Krieger".freeze]
  s.date = "2016-02-24"
  s.description = "The Ajax.org Cloud9 Editor (Ace) for the Rails 3.1 asset pipeline.".freeze
  s.email = ["cody@codykrieger.com".freeze]
  s.homepage = "https://github.com/codykrieger/ace-rails-ap".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "ace-rails-ap".freeze
  s.rubygems_version = "2.6.12".freeze
  s.summary = "The Ajax.org Cloud9 Editor (Ace) for the Rails 3.1 asset pipeline.".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
  end
end
