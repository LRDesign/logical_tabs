# Load the rails application
require File.expand_path('../application', __FILE__)
p "------------------- Test app environment being required"

# Initialize the rails application
AppRoot::Application.initialize!
