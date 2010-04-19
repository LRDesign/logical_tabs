require 'tabbed_panel'

# This contains the info for a single tab and pane
class TabPane
  attr_accessor :tabbed_panel, :name, :base_id, :content

  # tabbed_panel must be an instance of TabbedPanel
  #
  # Name is required, is used as the primary reference to this tab
  #
  # Other options:
  #   :base_id  The string used as the beginning of the ID for CSS
  #             IDs for the tab and pane.  :base_id => 'foo' will
  #             generate a tab with ID 'foo_tab' and a panel with ID
  #             'foo_panel'.  Defaults to name.downcase
  #   :text     The text to display in the tab.  Defaults to name.
  #   :content  The content for the panel itseld, in HTML
  #              
  def initialize(tabbed_panel, name, options = {})
    @tabbed_panel = tabbed_panel
    @name = name
    @base_id = options[:base_id] || name.downcase
    
  end
end
