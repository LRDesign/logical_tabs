
require 'spec_helper'
require 'logical_tabs/tab_pane'

describe LogicalTabs::TabPane do
  before(:each) do
    @view = ActionView::Base.new
    @tp = LogicalTabs::TabbedPanel.new(@view)
  end
  
  describe "initialization" do
    it "should initialize successfully" do
      LogicalTabs::TabPane.new(@tp, "Foo")  
    end
    it "should set the base_id to the default" do
      tp = LogicalTabs::TabPane.new(@tp, "Foo")        
      tp.base_id.should == 'foo'
    end
    it "should allow override of base_id" do
      tp = LogicalTabs::TabPane.new(@tp, "Foo", :base_id => 'bar')        
      tp.base_id.should == 'bar'      
    end
    it "should set the default tab text" do
      tp = LogicalTabs::TabPane.new(@tp, "Foo")        
      tp.tab_text.should == "Foo"
    end
    it "should set override tab text" do
      tp = LogicalTabs::TabPane.new(@tp, "Foo", :tab_text => "Bloop (3)")        
      tp.tab_text.should == "Bloop (3)"
    end
    it "should set the content" do
      tp = LogicalTabs::TabPane.new(@tp, "Foo", :content => "Lorem Ipsum")        
      tp.content.should == "Lorem Ipsum"
    end    
  end
  
  describe "render_tab" do
    before(:each) do
      @tp = LogicalTabs::TabPane.new(@tp, "Foo", :content => "Lorem Ipsum")              
    end
    it "should generate an li tag" do   
      p self.class
      debugger
      @tp.render_tab.should have_tag("li")
    end
  end
  
  
end