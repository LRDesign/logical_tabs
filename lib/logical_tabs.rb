
module LogicalTabs
  class Railtie < Rails::Railtie
    puts "------------------- Loading Railtie"
    require 'logical_tabs/helper'

    ActionController::Base.helper(LogicalTabs::Helper)
  end
end
