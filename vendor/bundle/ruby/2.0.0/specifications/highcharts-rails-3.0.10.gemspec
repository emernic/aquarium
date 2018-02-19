# -*- encoding: utf-8 -*-
# stub: highcharts-rails 3.0.10 ruby lib

Gem::Specification.new do |s|
  s.name = "highcharts-rails".freeze
  s.version = "3.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Per Christian B. Viken".freeze]
  s.date = "2014-03-11"
  s.description = "Gem that includes Highcharts (Interactive JavaScript charts for your web projects), in the Rails Asset Pipeline introduced in Rails 3.1".freeze
  s.email = ["perchr@northblue.org".freeze]
  s.homepage = "http://northblue.org/".freeze
  s.rubygems_version = "2.6.12".freeze
  s.summary = "Gem for easily adding Highcharts to the Rails Asset Pipeline".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
  end
end
