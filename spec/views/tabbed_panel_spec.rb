
require 'spec_helper'
require 'logical_tabs/tabbed_panel'

describe LogicalTabs::TabbedPanel do
  before(:each) do
    @view = ActionView::Base.new
  end
  it "should initialize successfully" do
    LogicalTabs::TabbedPanel.new(@view)  
  end
  
  describe "adding tab_panes" do
    describe "with specified content" do
      before(:each) do
        @panel = LogicalTabs::TabbedPanel.new(@view)
      end
      it "should create a panel with one tab" do
        @panel.add_tab('foo', :content => 'Lorem Ipsum')
        @panel.tabs.should have(1).tab
      end      
      it "should create a panel with one tab with the right content" do
        @panel.add_tab('foo', :content => 'Lorem Ipsum')
        @panel.tabs[0].content.should == 'Lorem Ipsum'       
      end
      it "should create a tab with a specific id" do
        @panel.add_tab('foo', :content => 'Lorem Ipsum', :base_id => 'bar')
        @panel.tabs[0].base_id.should == 'bar'               
      end
      it "should raise an exception if a tab with duplicate ID is added" do
        lambda do 
          @panel.add_tab('foo', :content => 'Lorem Ipsum', :base_id => 'bar')
          @panel.add_tab('foo 2', :content => 'Lorem Ipsum 2', :base_id => 'bar')
        end.should raise_error 
      end
    end  
  end
end