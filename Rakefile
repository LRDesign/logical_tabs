require 'rubygems'
require 'rubygems/installer'
require 'rake/gempackagetask'
require 'rake/gemcutter'
require 'hanna/rdoctask'
require 'spec/rake/spectask'
require 'mailfactory'
require 'net/smtp'

speclist = Dir[File.expand_path(__FILE__ +'/../*.gemspec')]
if speclist.length != 1
  puts "Found too many (or zero) *.gemspec files: #{speclist.inspect}"
  exit 1
end
load speclist[0]

require 'spec/rake/verify_rcov'

PACKAGE_DIR = "pkg"
directory "doc"

#spec_files = FileList["spec/**/*.rb"]

RakeConfig = {
  :email_servers => [ {
  :server => "ruby-lang.org", 
  :helo => "gmail.com"
} ],
  :announce_to_email => "ruby-talk@ruby-lang.org"
}

class SpecTask < Spec::Rake::SpecTask
  def initialize(name=:spec)
    super(name) do
      @spec_files = FileList["spec/**/*"]
      @libs = [%w{spec_help interpose}, %w{lib}, %w{spec_help}].map do|dir|
        File::join(File::dirname(__FILE__), *dir)
      end
      @ruby_opts = %w{-rubygems}
      self.spec_opts= %w{-f s --diff c --color}
      @rcov_opts = %w{--exclude [^/]*\.gemspec,^spec/,^spec_help/ --sort coverage --threshold 101 -o doc/coverage --xrefs --no-color} 
      @rcov = true
      @failure_message = "Spec examples failed."
      @verbose = true
      yield(self) if block_given?
    end
  end

  def spec_opts=(opts)
    @spec_opts = %w{-r cbt-tweaker -f e:last_run} + opts + %w{-r spec_helper -p spec/**/*.rb}
  end
end

task :needs_root do
  unless Process::uid == 0
    fail "This task must be run as root"
  end
end

desc "Run failing examples if any exist, otherwise, run the whole suite"
task :spec => "spec:quick"

namespace :spec do
  desc "Always run every spec"
  SpecTask.new(:all)

  desc "Generate spec/spec.opts"
  SpecTask.new(:spec_opts) do |t|
    t.spec_opts+= %w{--generate-options spec/spec.opts}
    t.rcov = false
  end

  desc "Generate specifications documentation"
  SpecTask.new(:doc) do |t|
    t.spec_opts = %w{-f s:doc/Specifications -b}
    t.failure_message = "Failed generating specification docs"
    t.verbose = false
  end

  desc "Run specs with Ruby profiling"
  SpecTask.new(:profile) do |t|
    t.ruby_opts += %w{-rprofile}
  end

  desc "Run only failing examples"
  SpecTask.new(:quick) do |t|
    t.spec_opts = %w{-f s --diff c --color --example last_run -b}
    t.rcov = false
    t.failure_message = "Spec examples failed."
  end

  task :clear_empty_last_run do
    begin
      if(/\A\s*Pending/m =~ File::read("last_run"))
        File::open("last_run", "w"){|f| f.write ""}
      end
    rescue Object => ex
      p [ex.class, ex.message]
    end
  end
  task :quick => :clear_empty_last_run
  desc "Run rspecs prior to a package publication"
  SpecTask.new(:check) do |t|
    t.spec_opts = %w{--format p:/dev/null}  
    t.failure_message = "Package does not conform to spec"
    t.verbose = false
  end

  desc "Open firefox to view RCov output"
  task :view_coverage => :doc do |t|
    sh "/usr/bin/chromium coverage/index.html"
  end
end

namespace :package do
  RCov::VerifyTask.new do |t|
    t.require_exact_threshold = false
    t.threshold = 90
    t.verbose = true
  end
  task :verify_rcov => ['spec:doc']

  task :chown_coverage do
    unless (user = ENV['SUDO_USER']).nil?
      FileUtils::chown_R(user, ENV['SUDO_GID'].to_i, 'coverage')
    end
  end

  package = Rake::GemPackageTask.new(SPEC) {|t|
    t.need_tar_gz = true
    t.need_tar_bz2 = true
  }
  task(:package).prerequisites.each do |package_type|
    file package_type => "spec:check"
  end

  Rake::RDocTask.new(:docs) do |rd|
    rd.options += SPEC.rdoc_options
    rd.rdoc_dir = 'rubydoc'
    rd.rdoc_files.include("lib/**/*.rb")
    rd.rdoc_files += (SPEC.extra_rdoc_files)
  end
  task :docs => ['spec:doc']
end

desc "Publish the gem and its documentation to Rubyforge and Gemcutter"
task :publish => ['publish:docs', 'publish:rubyforge', 'publish:gem:push']
namespace :publish do
  desc "Deploy gem via scp"
  task :scp, :dest, :destpath, :needs => :package do |t, args|
    destpath = args[:destpath] || "~"
    sh "scp", File::join(package.package_dir, package.gem_file), "#{args[:dest]}:#{destpath}"
    sh *(%w{ssh} + [args[:dest]] +  %w{sudo gem install} + [File::join(destpath, package.gem_file)])
  end

  task :sign_off => %w{package:verify_rcov package:gem package:chown_coverage}

  Rake::Gemcutter::Tasks.new(SPEC)
  task 'gem:push' => :sign_off
  task 'gem:install' => [:needs_root, :sign_off]
  task 'gem:reinstall' => :needs_root

  desc 'Publish RDoc to RubyForge'
  task :docs => 'package:docs' do
    config = YAML.load(File.read(File.expand_path("~/.rubyforge/user-config.yml")))
    host = "#{config["username"]}@rubyforge.org"
    remote_dir = "/var/www/gforge-projects/#{RUBYFORGE[:group_id]}"
    local_dir = 'rubydoc'
    sh %{rsync -av --delete #{local_dir}/ #{host}:#{remote_dir}}
  end

  task :scrape_rubyforge do
    require 'rubyforge'
    forge = RubyForge.new
    forge.configure
    forge.scrape_project(RUBYFORGE[:package_id])
  end

  desc "Publishes to RubyForge"
  task :rubyforge => ['package:verify_rcov', 'package:package', :docs, :scrape_rubyforge] do |t|
    require 'rubyforge'
    forge = RubyForge.new
    forge.configure
    files = [".gem", ".tar.gz", ".tar.bz2"].map do |extension|
      File::join(PACKAGE_DIR, SPEC.full_name) + extension
    end
    release = forge.lookup("release", RUBYFORGE[:package_id])[RUBYFORGE[:release_name]] rescue nil
    if release.nil?
      forge.add_release(RUBYFORGE[:group_id], RUBYFORGE[:package_id], RUBYFORGE[:release_name], *files)
    else
      files.each do |file|
        forge.add_file(RUBYFORGE[:group_id], RUBYFORGE[:package_id], RUBYFORGE[:release_name], file)
      end
    end
  end
end

def announcement # :nodoc:
  changes = ""
  begin
    File::open("./Changelog", "r") do |changelog|
      changes = "Changes:\n\n"
      changes += changelog.read
    end
  rescue Exception
  end

  urls = "Project: #{RUBYFORGE[:project_page]}\n" +
         "Homepage: #{RUBYFORGE[:home_page]}"

  subject = "#{SPEC.name} #{SPEC.version} Released"
  title = "#{SPEC.name} version #{SPEC.version} has been released!"
  body = "#{SPEC.description}\n\n#{changes}\n\n#{urls}"

  return subject, title, body
end

desc 'Announce release on RubyForge and email'
task :press => ['press:rubyforge', 'press:email']
namespace :press do
  desc 'Post announcement to rubyforge.'
  task :rubyforge do
    require 'rubyforge'
    subject, title, body = announcement

    forge = RubyForge.new
    forge.configure
    forge.post_news(RUBYFORGE[:group_id], subject, "#{title}\n\n#{body}")
    puts "Posted to rubyforge"
  end

  desc 'Generate email announcement file.'
  task :email do
    require 'rubyforge'
    subject, title, body= announcement

    mail = MailFactory.new
    mail.To = RakeConfig[:announce_to_email]
    mail.From = SPEC.email
    mail.Subject = "[ANN] " + subject
    mail.text = [title, body].join("\n\n")

    File.open("email.txt", "w") do |mailfile|
      mailfile.write mail.to_s
    end
    puts "Created email.txt"

    RakeConfig[:email_servers].each do |server_config|
      begin
        Net::SMTP.start(server_config[:server], 25, server_config[:helo], server_config[:username], server_config[:password]) do |smtp|
          smtp.send_message(mail.to_s, mail.From, mail.To)
        end
        break
      rescue Object => ex
        puts ex.message
      end
    end
  end
end
