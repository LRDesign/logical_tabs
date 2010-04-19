
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
    it "should set the default tab text" do
      tp = TabPane.new(@tp, "Foo")        
      tp.tab_text.should == "Foo"
    end
    it "should set override tab text" do
      tp = TabPane.new(@tp, "Foo", :tab_text => "Bloop (3)")        
      tp.tab_text.should == "Bloop (3)"
    end
    it "should set the content" do
      tp = TabPane.new(@tp, "Foo", :content => "Lorem Ipsum")        
      tp.content.should == "Lorem Ipsum"
    end
    
  end
  
  
end