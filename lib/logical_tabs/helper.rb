module LogicalTabs
  require 'logical_tabs/tabbed_panel'

  module Helper                                      
  
    def create_tabbed_panel(&block)
      tabbed_panel = TabbedPanel.new(self)
                          
      if block_given?                          
        output = capture(tabbed_panel, &block)
        output += tabbed_panel.render
        concat output
      end
      return tabbed_panel
    end   
      
    def wrap_in_div(id, &block)
      concat content_tag(:div, capture(&block), :class => 'wrapper', :id => id)    
    end
  end      
end
