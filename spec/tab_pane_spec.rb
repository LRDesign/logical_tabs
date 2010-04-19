
require 'tab_pane'
require 'action_view'

describe TabPane do
  before(:each) do
    @view = ActionView::Base.new
    @tp = TabbedPanel.new(@view)
  end
  
  describe "initialization" do
    it "should initialize successfully" do
      TabPane.new(@tp, "Foo")  
    end
    it "should set the base_id to the default" do
      tp = TabPane.new(@tp, "Foo")        
      tp.base_id.should == 'foo'
    end
    it "should allow override of base_id" do
      tp = TabPane.new(@tp, "Foo", :base_id => 'bar')        
      tp.base_id.should == 'bar'      
    end
  end
end