require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "test_erb/index", :type => :view do
  it "should render successfully" do
    render
  end

  it "should contain a tabbed panel" do
    render
    rendered.should have_selector('div.tabbed_panel')
  end
end
