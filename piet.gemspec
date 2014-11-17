# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "piet/version"

Gem::Specification.new do |s|
  s.name        = "piet"
  s.version     = Piet::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Albert Bellonch"]
  s.email       = ["albert@itnig.net"]
  s.homepage    = "http://itnig.net"
  s.summary     = %q{An image optimizer}
  s.description = %q{-}
  s.license     = 'MIT'

  s.rubyforge_project = "piet"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.add_dependency "png_quantizator"
  s.add_development_dependency "rspec"
  s.add_development_dependency "ZenTest"
  s.add_development_dependency "carrierwave"
  s.add_development_dependency "mini_magick"
  s.add_development_dependency "rmagick"
  s.add_development_dependency "rake"
end
