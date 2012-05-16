# coding: UTF-8

require 'pathname'

require 'tilt'
require 'sprockets'

require 'less_assets/version'
require 'less_assets/less_template'

if defined?(Rails)
  require 'rails'
  require 'less_assets/engine'
else
  require 'sprockets'
  require 'sprockets/engines'
  Sprockets.register_engine '.lesst', LessAssets::LessTemplate
end
