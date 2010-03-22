module LogicalTabsHelper                                    
  
  class TabbedPanel  
    include ActionView::Helpers::CaptureHelper 
    include ActionView::Helpers::TagHelper 
    include Haml::Helpers if defined?(Haml::Helpers) 
    
    def initialize(view)
      @view = view 
      @tabs = []
    end

    def output_buffer
      @view.output_buffer
    end

    def output_buffer=(val)
      @view.output_buffer = val
    end
        
    def add_tab(name, &block)         
      body = capture(&block)      
      @tabs << { :name => name, :body => body }
    end
         
    def tabs
      content_tag(:ul, 
        @tabs.map{ |tab| content_tag(:li, tab[:name], :class => 'tab') }.join,
        :class => 'tabs'
      )
    end
    def panels      
      @tabs.map{ |tab| content_tag(:div, tab[:body], :class => 'panel') }.join
    end
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
    
end
