module LogicalTabs
  class DuplicateTabID < Exception
  end
  
  # a collection of tabs with their associated panes, I.E. a tabbed panel
  class TabbedPanel      
    attr_reader :tabs, :base_id
    
    # view must be an instance of ActionView::Base.   This class 
    # depends on it for access to the capture and content_tag methods
    def initialize(view, options = {})
      @view = view 
      @tabs = []
      @base_id = options[:base_id] || build_generic_id(options)
    end

    def build_generic_id(options)
      base_id = "tabbed_panel"
      base_id += "_#{options[:seq]}" if options[:seq]
      base_id
    end  

    # Add a new tab (with pane) to this tabbed panel.   Either pass
    # a block with the content for the panel, or pass :content => 'my_content'.
    #
    # Name is required and serves as the internal identifier for the tab.  By
    # default, it is also the displayed text of the tab.
    #
    #
    # Other options:
    #   :base_id  The string used as the beginning of the ID for CSS
    #             IDs for the tab and pane.  :base_id => 'foo' will
    #             generate a tab with ID 'foo_tab' and a panel with ID
    #             'foo_panel'.  Defaults to name.downcase
    #
    #   :tab_text The text to display in the tab.  Defaults to name.
    #
    #   :content  The content for the panel itself, in HTML
    def add_tab(name, options = {},  &block)       
      # debugger  
      options[:content] ||= v.capture(&block)
      tab = TabPane.new(self, name, options)
      if @tabs.any?{ |t| t.base_id == tab.base_id } 
        raise DuplicateTabID
      else
        @tabs << tab
      end
    end

    # Render a UL containing all the tabs as LIs.   Which tab is
    # shown as selected is determined by the return value of selected?
    def render_tabs
      v.content_tag(:ul, 
        @tabs.map{ |tab| tab.render_tab(selected?(tab)) }.join,
        :class => 'tabs'
      )
    end

    # Render a sequence of DIVs containing the panes.
    def render_panes
      v.content_tag(:div, 
        @tabs.map{ |tab| tab.render_pane(selected?(tab)) }.join,
        :class => 'panes'
      )            
    end 
    
    # render the entire tabbed panel and all contents.
    def render  
      v.content_tag(:div,
        render_tabs + render_panes,
        :id => @base_id,
        :class => 'tabbed_panel'        
      )    
    end
    
    # For the moment, the first tab is the one selected
    def selected_tab
      @tabs.first
    end

    def selected?(tab)
      tab == selected_tab
    end

    # returns the array of TabPanes
    def tabs
      @tabs
    end

    # shortcut to the View
    def v; @view end

  end
end
  