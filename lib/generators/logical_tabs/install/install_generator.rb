module LogicalTabs
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc <<DESC
Description:
Copy LogicalTabs files to your application.
DESC

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def copy_files
        copy_file 'javascripts/logical_tabs_prototype.js', 'public/javascripts/logical_tabs_prototype.js'
        copy_file 'stylesheets/logical_tabs.css', 'public/stylesheets/logical_tabs.css'
      end

      def add_javascript
        file = File.join("public", "javascripts", "application.js")
      end

      def reminder
        say (<<NOTICE

LogicalTabs installed!  Remember to add the stylesheet and javascript link tags.

  <%= stylesheet_link_tag 'logical_tabs.css' %>
  <%= javascript_include_tag 'logical_tabs_prototype.js' %>
     -- OR --
  <%= javascript_include_tag 'logical_tabs_jquery.js' %>
NOTICE
        )
      end
    end
  end
end
