
require 'tabbed_panel'
require 'action_view'

describe TabbedPanel do
  before(:each) do
    @view = ActionView::Base.new
  end
  it "should initialize successfully" do
    TabbedPanel.new(@view)  
  end
end