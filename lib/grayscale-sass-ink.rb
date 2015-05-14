require 'grayscale-sass-ink/version'
require 'octopress-ink'

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
