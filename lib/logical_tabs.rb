
module LogicalTabs
  class Railtie < Rails::Railtie
    require 'logical_tabs/helper'

    ActionController::Base.helper(LogicalTabs::Helper)
  end
end
