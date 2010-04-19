module LogicalTabs
  require 'logical_tabs/tabbed_panel'

  # This contains the info for a single tab and pane
  class TabPane
    attr_accessor :tabbed_panel, :name, :base_id, :content, :tab_text, :pane_content

    # tabbed_panel must be an instance of TabbedPanel
    #
    # Name is required, is used as the primary reference to this tab
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
    #              
    def initialize(tabbed_panel, name, options = {})
      @tabbed_panel = tabbed_panel
      @name = name
      @base_id = options[:base_id] || name.downcase
      @tab_text = options[:tab_text] || name
      @content = options[:content] || ''
    end
  
    # Generates output for the tab.
    def render_tab
      v.content_tag(:li)
    end
    
    def render_panel
      v.content_tag(:div)
    end
  
  
    private
    # Shortcut to the view
    def v; @tabbed_panel.v; end 
  
  end
end