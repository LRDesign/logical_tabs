
# a collection of tabs with their associated panes, I.E. a tabbed panel
class TabbedPanel  
  @@start_tab_id = 0

  def initialize(view)
    @view = view 
    @tabs = []
  end

  def add_tab(name, options = {},  &block)       
    # debugger  
    body = v.capture(&block)
    tab_id = generate_tab_id(options)
    @tabs << { :name => name, :body => body }
  end
       
  def generate_tab_id
    
  end     
       
  def tabs
    v.content_tag(:ul, 
      @tabs.map{ |tab| v.content_tag(:li, tab[:name], :class => 'tab') }.join,
      :class => 'tabs'
    )
  end
  
  def render_tab(tab)
    cssclass = "tab" + selected?(tab) ? "selected" : "unselected"
    v.content_tag( :li, 
      tab[:name],
      :class => cssclass
    )
  end
  
  def panels      
    @tabs.map{ |tab| v.content_tag(:div, tab[:body], :class => 'panel') }.join
  end 
  
  # For the moment, the first tab is the one selected
  def selected_tab
    tabs.first
  end
  
  def selected?(tab)
    tab == selected_tab
  end
  
  # shortcut to the View
  def v; @view end
  
end