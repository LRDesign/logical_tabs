
require 'spec_helper'
require 'logical_tabs/tabbed_panel'

describe LogicalTabs::TabbedPanel do
  before(:each) do
    @view = ActionView::Base.new
  end
  it "should initialize successfully" do
    LogicalTabs::TabbedPanel.new(@view)  
  end
end