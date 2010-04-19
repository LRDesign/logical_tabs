module LogicalTabs
  # a collection of tabs with their associated panes, I.E. a tabbed panel
  class TabbedPanel  

    # view must be an instance of ActionView::Base.   This class 
    # depends on it for access to the capture and content_tag methods
    def initialize(view)
      @view = view 
      @tabs = []
    end

    def add_tab(name, options = {},  &block)       
      # debugger  
      options[:content] ||= v.capture(&block)
      @tabs << TabPane.new(self, name, options)
    end

    def render_tabs
      v.content_tag(:ul, 
        @tabs.map{ |tab| tab.render_tab }.join,
        :class => 'tabs'
      )
    end

    def render_panels      
      @tabs.map{ |tab| tab.render_panel }.join
    end 

    # For the moment, the first tab is the one selected
    def selected_tab
      @tabs.first
    end

    def selected?(tab)
      tab == selected_tab
    end

    # shortcut to the View
    def v; @view end

  end
end
  