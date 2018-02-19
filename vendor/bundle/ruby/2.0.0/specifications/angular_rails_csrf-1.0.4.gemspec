# -*- encoding: utf-8 -*-
# stub: angular_rails_csrf 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "angular_rails_csrf".freeze
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Sanders".freeze]
  s.date = "2015-06-04"
  s.description = "AngularJS style CSRF protection for Rails".freeze
  s.email = ["sanderjd@gmail.com".freeze]
  s.homepage = "https://github.com/jsanders/angular_rails_csrf".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.12".freeze
  s.summary = "Support for AngularJS $http service style CSRF protection in Rails".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.1.0"])
      s.add_runtime_dependency(%q<rails>.freeze, ["< 5", ">= 3"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 10.1.0"])
      s.add_dependency(%q<rails>.freeze, ["< 5", ">= 3"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 10.1.0"])
    s.add_dependency(%q<rails>.freeze, ["< 5", ">= 3"])
  end
end
