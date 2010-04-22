
require 'spec_helper'
require 'logical_tabs/tabbed_panel'

describe LogicalTabs::TabbedPanel do
  before(:each) do
    @view = ActionView::Base.new
  end
  it "should initialize successfully" do
    LogicalTabs::TabbedPanel.new(@view)  
  end
  
  describe "generating tabbed panels" do
    it "should generate a tabbed panel" do
      @panel = LogicalTabs::TabbedPanel.new(@view)
      @panel.should be_a(LogicalTabs::TabbedPanel)
    end
    it "should append an id to the tabbed panel" do
      @panel = LogicalTabs::TabbedPanel.new(@view, :seq => 0)
      @panel.base_id.should == "tabbed_panel_0"  
    end
    it "should use a specified base_id rather than a sequence if specified" do
      @panel = LogicalTabs::TabbedPanel.new(@view, :base_id => 'my_panel')            
      @panel.base_id.should == "my_panel"         
    end
  end
  
  describe "rendering the output" do
    before(:each) do
      @panel = LogicalTabs::TabbedPanel.new(@view)
      @panel.add_tab('foo', :content => "Lorem ipsum")  
      @panel.add_tab('bar', :content => "dolor sit amet.")  
    end
    
    describe "rendering the whole panel" do
      before(:each) { @output = @panel.render }
      it "should render an outer div" do
        @output.should have_tag('div#tabbed_panel.tabbed_panel')
      end
      it "should render an outer div containing the tabs and panes" do        
        @output.should have_tag('div#tabbed_panel') do
          with_tag('ul.tabs')
          with_tag('div.panes')
        end        
      end
    end
    
    describe "rendering tabs" do
      before(:each) do
        @output = @panel.render_tabs
      end
      it "should render a url" do
        @output.should have_tag("ul.tabs")
      end
      it "should render an li for each tab" do
        @output.should have_tag("ul") do
          with_tag ("li##{@panel.base_id}_tp_foo_tab")
          with_tag ("li##{@panel.base_id}_tp_bar_tab")
        end        
      end
      it "should render the first li selected by default" do
        @output.should have_tag("li##{@panel.base_id}_tp_foo_tab.tab_selected")
        @output.should have_tag("li##{@panel.base_id}_tp_bar_tab.tab_unselected")        
      end
    end
    
    describe "rendering the panes" do
      before(:each) do
        @output = @panel.render_panes
      end
      it "should render an outer div of class panes" do
        @output.should have_tag('div.panes')
      end
      it "should render a div for each tab" do
        @output.should have_tag('div.panes') do         
          with_tag("div##{@panel.base_id}_tp_foo_pane")
          with_tag("div##{@panel.base_id}_tp_bar_pane")
        end
      end
      it "should render the first div selected by default" do
        @output.should have_tag("div##{@panel.base_id}_tp_foo_pane.pane_selected")
        @output.should have_tag("div##{@panel.base_id}_tp_bar_pane.pane_unselected")
      end      
    end
  end
  
  
  describe "adding tab_panes" do
    before(:each) do
      @panel = LogicalTabs::TabbedPanel.new(@view)
    end
    describe "with specified content" do
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
    
    describe "with block content" do
      it "should create a panel with one tab" do
        @panel.add_tab('foo') { "Lorem Ipsum" }
        @panel.tabs.should have(1).tab        
      end
      it "should create a panel with one tab with the right content" do
        @panel.add_tab('foo') { "Lorem Ipsum" }
        @panel.tabs[0].content.should == 'Lorem Ipsum'       
      end
    end
  end
end