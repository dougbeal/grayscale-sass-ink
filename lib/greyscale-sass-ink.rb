require 'greyscale-sass-ink/version'
require 'octopress-ink'

Octopress::Ink.add_plugin({
  name:          "Greyscale Sass Ink",
  slug:          "greyscale-sass-ink",
  gem:           "greyscale-sass-ink",
  path:          File.expand_path(File.join(File.dirname(__FILE__), "..")),
  version:       GreyscaleSassInk::VERSION,
  description:   "",                                # What does your theme/plugin do?
  source_url:    "https://github.com/user/project", # <- Update info
  website:       ""                                 # Optional project website
})
