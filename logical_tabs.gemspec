Gem::Specification.new do |s|
  s.name = %q{logical_tabs}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Evan Dorn"]
  s.date = %q{2011-02-15}
  s.summary = %q{Tabbed panel helper tool for Rails}
  s.description = %q{LogicalTabs assists in the creation of a semantic
    HTML markup for a tabbed panel UI setup that will be reasonable
    and functional when JavaScript is unavaliable and has sensible default
    print styling.  JavaScript is provided for use with either jQuery or
    Prototype.
  }
  s.email = %q{evan@lrdesign.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION"
  ]
  s.files		+= Dir.glob("lib/**/*")
  s.files		+= Dir.glob("doc/**/*")
  s.files		+= Dir.glob("javascripts/**/*")
  s.files		+= Dir.glob("stylesheets/**/*")
  s.files		+= Dir.glob("tasks/**/*")

  s.homepage = %q{http://github.com/LRDesign/mizugumo}
  s.licenses = ["MIT"]
  s.require_paths = ["lib/"]
  s.rubygems_version = %q{1.3.5}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.5"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.5"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.5"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

