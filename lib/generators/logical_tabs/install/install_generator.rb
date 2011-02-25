module LogicalTabs
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option  :css,
                    :type => :string,
                    :desc => "Type of CSS to install, (css, sass, or none), default css",
                    :default => "css"

      class_option  :js,
                    :type => :string,
                    :desc => "Type of JS to install, (prototype, jquery, or none), default prototype",
                    :default => 'prototype'


      desc <<DESC
Description:
Copy LogicalTabs files to your application.
DESC

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def check_options
        quit_with_options_error unless %w(css sass none).include?(options[:css])
        quit_with_options_error unless %w(prototype jquery none).include?(options[:js])
      end

      def install_javascript
        case options[:js]
        when 'prototype':  copy_file 'javascripts/logical_tabs_prototype.js', 'public/javascripts/logical_tabs_prototype.js'
        when 'jquery':  copy_file 'javascripts/logical_tabs_prototype.js', 'public/javascripts/logical_tabs_prototype.js'
        end
      end

      def install_stylesheet
        case options[:css]
        when 'css': copy_file 'stylesheets/logical_tabs.css', 'public/stylesheets/logical_tabs.css'
        when 'sass': copy_file 'stylesheets/sass/logical_tabs.sass', 'public/stylesheets/sass/logical_tabs.sass'
        end
      end

      def add_javascript
        file = File.join("public", "javascripts", "application.js")
      end

      def reminder
        say <<NOTICE

LogicalTabs installed!  Remember to add the stylesheet and javascript link tags.

  <%= stylesheet_link_tag 'logical_tabs.css' %>
  <%= javascript_include_tag 'logical_tabs_prototype.js' %>
     -- OR --
  <%= javascript_include_tag 'logical_tabs_jquery.js' %>
NOTICE
      end


      private
      def quit_with_options_error
        say <<END_OF_ERROR

Invalid option specified.  If options are specified:
  --css must be one of [ css, sass, none ]
  --js must be one of [ prototype, jquery, none ]

END_OF_ERROR
        exit(1)
      end

    end
  end
end
