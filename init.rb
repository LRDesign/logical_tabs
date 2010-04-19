require File.join(File.dirname(__FILE__), "lib", "logical_tabs", "helper")  
ActionView::Base.send :include, LogicalTabs::Helper  
