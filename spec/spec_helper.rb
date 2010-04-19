begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

require 'spec/rails'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

module ActiveSupport
  class TestCase
    include ::Spec::Rails::Matchers
    include ::Spec::Rails::Mocks
  end
end