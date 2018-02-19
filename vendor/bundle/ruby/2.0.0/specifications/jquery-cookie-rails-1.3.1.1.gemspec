# -*- encoding: utf-8 -*-
# stub: jquery-cookie-rails 1.3.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-cookie-rails".freeze
  s.version = "1.3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ryan Scott Lewis".freeze]
  s.date = "2013-09-24"
  s.description = "This gem provides jquery-cookie assets for your Rails 3 application.".freeze
  s.email = "ryan@rynet.us".freeze
  s.homepage = "http://github.com/RyanScottLewis/jquery-cookie-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.12".freeze
  s.summary = "Use jquery-cookie with Rails 3".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.2.0"])
      s.add_development_dependency(%q<rails>.freeze, ["~> 3.2"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<uglifier>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<sass>.freeze, ["~> 3.2"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<fancy_logger>.freeze, ["~> 0.1"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 2.13"])
      s.add_development_dependency(%q<fuubar>.freeze, ["~> 1.1"])
    else
      s.add_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.2.0"])
      s.add_dependency(%q<rails>.freeze, ["~> 3.2"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_dependency(%q<uglifier>.freeze, ["~> 1.3"])
      s.add_dependency(%q<sass>.freeze, ["~> 3.2"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<fancy_logger>.freeze, ["~> 0.1"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 2.13"])
      s.add_dependency(%q<fuubar>.freeze, ["~> 1.1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.2.0"])
    s.add_dependency(%q<rails>.freeze, ["~> 3.2"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_dependency(%q<uglifier>.freeze, ["~> 1.3"])
    s.add_dependency(%q<sass>.freeze, ["~> 3.2"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<fancy_logger>.freeze, ["~> 0.1"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 2.13"])
    s.add_dependency(%q<fuubar>.freeze, ["~> 1.1"])
  end
end
