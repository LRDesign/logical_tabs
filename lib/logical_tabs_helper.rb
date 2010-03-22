module LogicalTabsHelper                                    
  
  class TabbedPanel  

    def initialize(view)
      @view = view 
      @tabs = []
    end

    def add_tab(name, &block)       
      # debugger  
      body = v.capture(&block)
      @tabs << { :name => name, :body => body }
    end
         
    def tabs
      v.content_tag(:ul, 
        @tabs.map{ |tab| v.content_tag(:li, tab[:name], :class => 'tab') }.join,
        :class => 'tabs'
      )
    end
    def panels      
      @tabs.map{ |tab| v.content_tag(:div, tab[:body], :class => 'panel') }.join
    end 
    
    # shortcut to the View
    def v; @view end
    
  end
  
  def create_tabbed_panel(&block)
    tabbed_panel = TabbedPanel.new(self)
                          
    if block_given?                          
      output = capture(tabbed_panel, &block)
      output += tabbed_panel.tabs
      output += tabbed_panel.panels
      concat content_tag(:div, output, :class => "tabbed_panel")
    end
    return tabbed_panel
  end   
  
  def wrap_in_div(id, &block)
    concat content_tag(:div, capture(&block), :class => 'wrapper', :id => id)    
  end
    
end
