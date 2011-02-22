require 'rake'

desc 'Default: Run all specs.'
task :default => :all_specs

desc "Run all specs"
task :all_specs do
  Dir['spec/*/Rakefile'].each do |rakefile|
    directory_name = File.dirname(rakefile)
    puts "=========== Running specs in #{directory_name}"
    sh <<-CMD
      cd #{directory_name}
      bundle exec rake
    CMD
  end
end