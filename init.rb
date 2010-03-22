require File.join(File.dirname(__FILE__), "lib", "logical_tabs_helper")  
ActionView::Base.send :include, LogicalTabsHelper  
