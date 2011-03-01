module LogicalTabs
  require 'logical_tabs/tabbed_panel'

  module Helper
    def tabbed_panel( options = {}, &block)
      @panel_count = defined?(@panel_count) ? @panel_count + 1 : 0
      options.merge!({:seq => @panel_count}) unless options[:base_id]
      tabbed_panel = TabbedPanel.new(self, options)

      if block_given?
        yield(tabbed_panel)
        output = tabbed_panel.render
        output
      end
      return output
    end

    alias_method :create_tabbed_panel, :tabbed_panel

    def wrap_in_div(id, &block)
      content_tag(:div, capture(&block), :class => 'wrapper', :id => id)
    end
  end
end
