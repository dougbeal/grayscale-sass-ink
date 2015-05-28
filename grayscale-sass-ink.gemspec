# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grayscale-sass-ink/version'

Gem::Specification.new do |spec|
  spec.name          = "grayscale-sass-ink"
  spec.version       = GrayscaleSassInk::VERSION
  spec.authors       = ["Douglas Beal"]
  spec.email         = ["git@dougbeal.com"]

  spec.summary       = %q{Grayscale Sass Octopress Ink Plugin.}
  spec.description   = %q{Grayscale Sass Octopress Ink Plugin.  Uses bower for javascript management.}
  spec.homepage      = "https://github.com/dougbeal/grayscale-sass-ink"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").grep(%r{^(bin/|lib/|assets/|changelog|readme|license)}i)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "octopress-ink", "~> 1.1"
  spec.add_runtime_dependency "jekyll"
  spec.add_runtime_dependency "sass"
  spec.add_runtime_dependency('jekyll-sass-converter', '~> 1.0')

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "clash"
end
