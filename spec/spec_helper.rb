Dir[File::expand_path(__FILE__ + "/../support/**/*.rb")].each{|file| require file}
Ungemmer::ungem_gemspec
# require 'spec/rails'

# module ActiveSupport
#   class TestCase
#     include ::Spec::Rails::Matchers
#     include ::Spec::Rails::Mocks
#   end
# end
