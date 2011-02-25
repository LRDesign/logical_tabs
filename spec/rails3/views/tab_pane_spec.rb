
require 'spec_helper'
require 'logical_tabs/tab_pane'

describe LogicalTabs::TabPane, :type => :view do
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
    it "should snake case the default base_id" do
      tp = LogicalTabs::TabPane.new(@tp, "Foo Bar")
      tp.base_id.should == "foo_bar"
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

  describe "tab_link" do
    before(:each) do
      @tab_pane = LogicalTabs::TabPane.new(@tp, "Foo", :content => "Lorem Ipsum", :base_id => 'bar')
    end
    it "should generate a link with the right class" do
      @tab_pane.tab_link.should have_selector("a.tab_link")
    end
  end

  describe "render_tab" do
    before(:each) do
      @tab_pane = LogicalTabs::TabPane.new(@tp, "Foo", :content => "Lorem Ipsum", :base_id => 'bar')
    end
    it "should generate an li tag with the text" do
      @tab_pane.render_tab.should have_selector("li") do |scope|
        scope.should contain(@tab_pane.tab_text)
      end
    end
    it "should render the correct id, including prefix from the panel" do
      @tab_pane.render_tab.should have_selector("li##{@tp.base_id}_tp_bar_tab")
    end
    it "should have class 'tab'" do
      @tab_pane.render_tab.should have_selector("li.tab")
    end
    it "should have class 'unselected' by default" do
      @tab_pane.render_tab.should have_selector("li.tab_unselected")
    end
    it "should have class 'selected' when called with selected = true" do
      @tab_pane.render_tab(true).should have_selector("li.tab_selected")
    end
    it "should have an li tag with a link to #" do
      @tab_pane.render_tab.should have_selector("li") do |scope|
        scope.should have_selector("a[href='#']") do |s2|
          s2.should contain(@tab_pane.tab_text)
        end
      end
    end
  end

  describe "render_pane" do
    before(:each) do
      @tab_pane = LogicalTabs::TabPane.new(@tp, "Foo", :content => "Lorem Ipsum", :base_id => 'bar')
    end
    it "should generate a div tag" do
      @tab_pane.render_pane.should have_selector("div")
    end
    it "should generate a div tag with the content" do
      @tab_pane.render_pane.should have_selector("div") do |scope|
        scope.should contain("Lorem Ipsum")
      end
    end
    it "should render a div tag with the correct id" do
      @tab_pane.render_pane.should have_selector("div##{@tp.base_id}_tp_bar_pane")
    end
    it "should set the class to 'pane'" do
      @tab_pane.render_pane.should have_selector("div.pane")
    end
    it "should set the class to 'pane_unselected' by default" do
      @tab_pane.render_pane.should have_selector("div.pane_unselected")
    end
    it "should set the class to 'pane_selected' if rendered selected" do
      @tab_pane.render_pane(true).should have_selector("div.pane_selected")
    end
    it "should contain the print header" do
      @tab_pane.render_pane.should have_selector("div.pane") do |scope|
        scope.should have_selector('h3.pane_print_header')
      end
    end
  end

  describe "render_header" do
    before { @tab_pane = LogicalTabs::TabPane.new(@tp, "Foo", :content => "Lorem Ipsum", :base_id => 'bar') }
    it "should generate an h3 tag with class 'pane_print_header'" do
      @tab_pane.render_header.should have_selector("h3.pane_print_header")
    end
    it "should generate an h3 with the tab text" do
      @tab_pane.render_header.should have_selector("h3.pane_print_header") do |scope|
        scope.should contain('Foo')
      end
    end

  end


end