Dir[File::expand_path(__FILE__ + "/../support/**/*.rb")].each{|file| require file}

Ungemmer::ungem_gemspec
