require 'rubygems'

SPEC = Gem::Specification.new do |spec|
  spec.name		= ""
  spec.version		= "0.0.1"
  spec.author		= "Judson Lester" #single author is assumed
  spec.email		= "judson@lrdesign"
  spec.summary		= ""
  spec.description	= <<-EOD
  EOD

  spec.rubyforge_project= spec.name.downcase
  spec.homepage        = "http://#{spec.rubyforge_project}.rubyforge.org/"


  spec.files		= %w[
    # For each of these lines, d$ then @"
    # !!find lib -type f
    # !!find app -type f
    # !!find doc -type f
    # !!find spec -type f
    # !!find generators -type f
  ]

  spec.test_file        = "spec_help/gem_test_suite.rb"
  
  spec.require_path	= "lib" 

  spec.has_rdoc		= true
  spec.extra_rdoc_files = Dir.glob("doc/**/*")
  spec.rdoc_options	= %w{--inline-source }
  spec.rdoc_options	+= %w{--main doc/README }
  spec.rdoc_options	+= ["--title", "#{spec.name}-#{spec.version} RDoc"]

  #spec.add_dependency("postgres", ">= 0.7.1")

  spec.post_install_message = "Another tidy package brought to you by Logical Reality Design"
end

RUBYFORGE = {
  :group_id => SPEC.rubyforge_project,
  :package_id => SPEC.name.downcase,
  :release_name => SPEC.full_name,
  :home_page => SPEC.homepage,
  :project_page => "http://rubyforge.org/project/#{SPEC.rubyforge_project}/"
}

SPEC
