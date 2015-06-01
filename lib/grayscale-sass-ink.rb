require 'find'
require 'jekyll'
require 'jekyll/converters/scss'
require 'octopress-ink'


require 'grayscale-sass-ink/version'
puts('greyscale-sass-ink.rb loaded')


# add sass paths in bower components for sass engine search path
module GrayscaleSassInk
  module InkModifyLoadPaths
    def bower_sass_load_paths
      unless @bower_sass_load_paths
        @bower_sass_load_paths = []
        base = File.join Octopress::Ink.configuration["source"], "bower_components"
        Find.find(base) do |path|
          if FileTest.directory?(path)
            basename = File.basename(path)
            if ["scss", "stylesheets"].include? basename
              sanitized_path = Jekyll.sanitized_path(base, path)
              puts( "found path " + sanitized_path)
              @bower_sass_load_paths << sanitized_path
            else
              next
            end
          end
        end
      end
      @bower_sass_load_paths
    end
    def load_paths #sass_load_paths
      Jekyll.logger.debug "grayscale-sass-ink: inserting bower sass/stylesheet paths. #{bower_sass_load_paths}"
      (super + bower_sass_load_paths).uniq.select { |load_path|
        !load_path.is_a?(String) || File.directory?(load_path)
      }
    end
  end

  module JekyllModifyLoadPaths
    def bower_sass_load_paths
      unless @bower_sass_load_paths
        @bower_sass_load_paths = []
        base = File.join Octopress::Ink.configuration["source"], "bower_components"
        Find.find(base) do |path|
          if FileTest.directory?(path)
            basename = File.basename(path)
            if ["scss", "stylesheets"].include? basename
              sanitized_path = Jekyll.sanitized_path(base, path)
              puts( "found path " + sanitized_path)
              @bower_sass_load_paths << sanitized_path
            else
              next
            end
          end
        end
      end
      @bower_sass_load_paths
    end
    def sass_load_paths
      Jekyll.logger.debug "grayscale-sass-ink: inserting bower sass/stylesheet paths. #{bower_sass_load_paths}"
      (super + bower_sass_load_paths).uniq.select { |load_path|
        !load_path.is_a?(String) || File.directory?(load_path)
      }
    end
  end

  module AssetPathOverride
    def add_javascripts
      super
      config['bower']['javascripts'].map do |component, files|
        Jekyll.logger.debug "greyscale-sass-ink: #{component} javascript assets"
        files.each do |file|
          full_path = File.join(@path, file)
          add_javascript_asset("..", file) if File.exist?(full_path)
        end
      end
    end
    def add_fonts
      super
      config['bower']['fonts'].map do |component, directory|
        Jekyll.logger.debug "greyscale-sass-ink: #{component} font assets"
        full_dir = File.join(@path, directory)
        glob_assets(full_dir).map do |file|
          file = File.join(directory, File.basename(file))
          asset = Octopress::Ink::Assets::Asset.new(self, "..", file)
          @fonts << asset
          puts("added font #{file}")
        end
      end
    end
  end
end



Octopress::Ink::Assets::Sass.prepend GrayscaleSassInk::InkModifyLoadPaths
Jekyll::Converters::Scss.prepend GrayscaleSassInk::JekyllModifyLoadPaths

puts "create plugin"

Octopress::Ink::Plugin.prepend GrayscaleSassInk::AssetPathOverride
Octopress::Ink.add_plugin({
  name:          "Grayscale Octopress Ink Theme",
  slug:          "grayscale-sass-ink",
  gem:           "grayscale-sass-ink",
  path:          File.expand_path(File.join(File.dirname(__FILE__), "..")),
  version:       GrayscaleSassInk::VERSION,
  description:   "",                                # What does your theme/plugin do?
  source_url:    "https://github.com/user/project", # <- Update info
  website:       ""                                 # Optional project website
})
