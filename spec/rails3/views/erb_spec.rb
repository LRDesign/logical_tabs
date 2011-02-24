require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "test_erb/index", :type => :view do
  before { render }

  it "should render successfully" do
  end

  it "should contain a tabbed panel" do
    rendered.should have_selector('div.tabbed_panel')
  end

  it "should number the tabbed panel" do
    rendered.should have_selector('#tabbed_panel_0')
  end

  it "should contain a tabs UL with six tab LIs" do
    rendered.should have_selector('#tabbed_panel_0') do |scope|
      scope.should have_selector('ul.tabs') do |scope2|
        scope2.should have_selector('li.tab')
      end
    end
  end

  it "should contain a panes DIV with six pane DIVs" do
    rendered.should have_selector('#tabbed_panel_0') do |scope|
      scope.should have_selector('div.panes') do |scope2|
        scope2.should have_selector('div.pane')
      end
    end
  end

  it "should contain tabs with the proper text and IDs" do
    rendered.should have_selector('#tabbed_panel_0') do |scope|
      scope.should have_selector("li.tab[id='tabbed_panel_0_tp_tab_one_tab']") do |scope2|
        scope2.should have_selector("a.tab_link"){ |s3| s3.should contain(/Tab One/)}
      end
      scope.should have_selector("li.tab[id='tabbed_panel_0_tp_tab_two_tab']") do |scope2|
        scope2.should have_selector("a.tab_link"){ |s3| s3.should contain(/Tab Two/)}
      end
      scope.should have_selector("li.tab[id='tabbed_panel_0_tp_tab_foo_tab']") do |scope2|
        scope2.should have_selector("a.tab_link"){ |s3| s3.should contain(/Tab Foo/)}
      end
    end
  end

  it "should contain panes with the proper content and IDs" do
    rendered.should have_selector('#tabbed_panel_0') do |scope|
      scope.should have_selector('div.pane#tabbed_panel_0_tp_tab_one_pane') do |s2|
        s2.should contain("Content for Tab One")
      end
      scope.should have_selector('div.pane#tabbed_panel_0_tp_tab_two_pane') do |s2|
        s2.should contain("Content for Tab Two")
      end
      scope.should have_selector('div.pane#tabbed_panel_0_tp_tab_foo_pane') do |s2|
        s2.should contain("unsafe")
      end
    end
  end

  it "should not allow unsafe content through unescaped" do
    rendered.should_not have_selector('script')
  end
end
