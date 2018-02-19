# -*- encoding: utf-8 -*-
# stub: db-charmer 1.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "db-charmer".freeze
  s.version = "1.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Oleksiy Kovyrin".freeze]
  s.date = "2014-11-14"
  s.description = "DbCharmer is a Rails plugin (and gem) that could be used to manage AR model connections, implement master/slave query schemes, sharding and other magic features many high-scale applications need.".freeze
  s.email = "alexey@kovyrin.net".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.homepage = "http://kovyrin.github.io/db-charmer/".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.6.12".freeze
  s.summary = "ActiveRecord Connections Magic (slaves, multiple connections, etc)".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, ["< 4.0.0"])
      s.add_runtime_dependency(%q<activerecord>.freeze, ["< 4.0.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<actionpack>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, ["< 4.0.0"])
      s.add_dependency(%q<activerecord>.freeze, ["< 4.0.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<actionpack>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, ["< 4.0.0"])
    s.add_dependency(%q<activerecord>.freeze, ["< 4.0.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<actionpack>.freeze, [">= 0"])
  end
end
