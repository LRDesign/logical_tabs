require 'rubygems'

SPEC = Gem::Specification.new do |spec|
  spec.name = "logical_tabs"
  spec.version = "0.1.0"

  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  spec.authors = ["Evan Dorn", "Judson Lester"]
  spec.date = "2011-02-15"
  spec.summary = "Tabbed panel helper tool for Rails"
  spec.description = <<-EndDescription
    LogicalTabs assists in the creation of a semantic
    HTML markup for a tabbed panel UI setup that will be reasonable
    and functional when JavaScript is unavaliable and has sensible default
    print styling.  JavaScript is provided for use with either jQuery or
    Prototype.
  EndDescription

  spec.email = "evan@lrdesign.com"
  # spec.extra_rdoc_files = [
  #   "LICENSE.txt",
  #   "README.rdoc"
  # ]
  # spec.files = %w[
  #   Gemfile
  #   Gemfile.lock
  #   LICENSE.txt
  #   README.rdoc
  #   Rakefile
  #   VERSION
  #   # For each of these lines, d$ then @"
  #   # !!find doc -type f
  #   # !!find spec -type f
  #   # !!find lib -type f
  #   # !!find app -type f
  #   # !!find public -type f
  #   # !!find tasks -type f
  #   # !!find generators -type f
  # ]
  spec.files += Dir.glob("lib/**/*")
  spec.files += Dir.glob("doc/**/*")
  spec.files += Dir.glob("spec/**/*")

  spec.test_file        = "spec_help/gem_test_suite.rb"

  spec.homepage = "http://lrdesign.com/tools"
  spec.licenses = ["MIT"]
  spec.require_paths = ["lib/"]
  spec.rubygems_version = "1.3.5"

  if spec.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    spec.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      spec.add_development_dependency("rspec", [">= 1.5"])
      spec.add_development_dependency("bundler", ["~> 1.0.0"])
      spec.add_development_dependency("rcov", [">= 0"])
    else
      spec.add_dependency("rspec", [">= 1.5"])
      spec.add_dependency("bundler", ["~> 1.0.0"])
      spec.add_dependency("rcov", [">= 0"])
    end
  else
    spec.add_dependency("rspec", [">= 1.5"])
    spec.add_dependency("bundler", ["~> 1.0.0"])
    spec.add_dependency("rcov", [">= 0"])
  end

  # spec.rubyforge_project= spec.name.downcase
  #
  # spec.require_path = "lib"
  #
  # spec.has_rdoc   = true
  # spec.extra_rdoc_files = Dir.glob("doc/**/*")
  # spec.rdoc_options = %w{--inline-source }
  # spec.rdoc_options += %w{--main doc/README }
  # spec.rdoc_options += ["--title", "#{spec.name}-#{spec.version} RDoc"]

  #spec.add_dependency("postgres", ">= 0.7.1")

  spec.post_install_message = "Another tidy package brought to you by Logical Reality Design"
end

# RUBYFORGE = {
#   :group_id => SPEC.rubyforge_project,
#   :package_id => SPEC.name.downcase,
#   :release_name => SPEC.full_name,
#   :home_page => SPEC.homepage,
#   :project_page => "http://rubyforge.org/project/#{SPEC.rubyforge_project}/"
# }

SPEC
