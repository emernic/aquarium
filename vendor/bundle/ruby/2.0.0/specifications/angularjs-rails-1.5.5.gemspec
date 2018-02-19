# -*- encoding: utf-8 -*-
# stub: angularjs-rails 1.5.5 ruby lib

Gem::Specification.new do |s|
  s.name = "angularjs-rails".freeze
  s.version = "1.5.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hirav Gandhi".freeze]
  s.date = "2016-04-28"
  s.description = "Injects Angular.js into your asset pipeline as well as other Angular modules.".freeze
  s.email = "hgandhi@alumni.stanford.edu".freeze
  s.homepage = "https://github.com/hiravgandhi/angularjs-rails/".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.12".freeze
  s.summary = "Angular.js on Rails".freeze

  s.installed_by_version = "2.6.12" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<versionomy>.freeze, [">= 0"])
      s.add_development_dependency(%q<nokogiri>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<versionomy>.freeze, [">= 0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<versionomy>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
  end
end
