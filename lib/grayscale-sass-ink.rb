require 'find'
require 'pathname'
require 'jekyll'
require 'jekyll/converters/scss'
require 'octopress-ink'


require 'grayscale-sass-ink/version'

puts("greyscale-sass-ink.rb loaded version #{GrayscaleSassInk::VERSION}.")

# add sass paths in bower components for sass engine search path
module GrayscaleSassInk
  PATH = File.expand_path(File.join(File.dirname(__FILE__), ".."))
  def version
    version = "Jekyll v#{Jekyll::VERSION}, "
    if defined? Octopress::VERSION
      version << "Octopress v#{Octopress::VERSION} "
    end
    version << "Octopress Ink v#{Octopress::Ink::VERSION}, "
    version << "Octopress Ink Grayscale-Sass v#{GrayscaleSassInk::VERSION}"
  end

  def self.get_stylesheet_paths
    get_stylesheet_paths = []
    bases = [Octopress::Ink.configuration["source"], PATH]
    bases = bases.map { |b|  Pathname.new(b).cleanpath }
    for base in bases
      bower_dir = base.join "bower_components"
      get_stylesheet_paths.push bower_dir
      puts( "path #{bower_dir}" )
      bower_dir.each_child do |bower_component|
        if bower_component.directory?
          # sanitized_path = Jekyll.sanitized_path(base, path)
          path = bower_component.to_s
          puts( "found path  " + path)
          get_stylesheet_paths.push path
          bower_component.find do |comp|
            if not comp.directory?
              next
            elsif ["scss", "stylesheets"].include? comp.basename.to_s
              sanitized_comp = Jekyll.sanitized_path(base.to_s, comp.to_s)
              puts( "found path ink scss/ss " + sanitized_comp)
              get_stylesheet_paths.push sanitized_comp
              Find.prune
            end
          end
        end
      end
    end
    return get_stylesheet_paths
  end

  module InkModifyLoadPaths
    def bower_sass_load_paths
      unless @bower_sass_load_paths
        @bower_sass_load_paths = GrayscaleSassInk::get_stylesheet_paths
      end
      @bower_sass_load_paths
    end

    def load_paths #sass_load_paths
      puts("grayscale-sass-ink: inserting bower sass/stylesheet paths. #{bower_sass_load_paths}")
      Jekyll.logger.debug "grayscale-sass-ink: inserting bower sass/stylesheet paths. #{bower_sass_load_paths}"
      (super + bower_sass_load_paths).uniq.select { |load_path|
        !load_path.is_a?(String) || File.directory?(load_path)
      }
    end
  end

  module JekyllModifyLoadPaths
    def bower_sass_load_paths
      unless @bower_sass_load_paths
        @bower_sass_load_paths = GrayscaleSassInk::get_stylesheet_paths
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
          puts("added javascript #{file}")
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
  path:          GrayscaleSassInk::PATH,
  version:       GrayscaleSassInk::VERSION,
  description:   "",                                # What does your theme/plugin do?
  source_url:    "https://github.com/dougbeal/grayscale-sass-ink", # <- Update info
  website:       ""                                 # Optional project website
})
