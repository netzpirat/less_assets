# coding: UTF-8
require File.expand_path('../lib/less_assets/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'less_assets'
  s.version     = LessAssets::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Michael Kessler']
  s.email       = ['michi@netzpiraten.ch']
  s.homepage    = 'https://github.com/netzpirat/less_assets'
  s.summary     = 'Less JavaScript Style Templates'
  s.description = 'Less JavaScript Style Templates in the asset pipeline.'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'less_assets'

  s.files         = Dir.glob('{app,lib,vendor}/**/*') + %w[LICENSE README.md]

  s.add_runtime_dependency "tilt", ">= 1.3.3"
  s.add_runtime_dependency "sprockets", ">= 2.0.3"

  s.add_development_dependency 'bundler'

  s.add_development_dependency 'railties',    '>= 3.1'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
end
