require 'rails'
require 'rails/all'
require 'jasminerice'
require 'sprockets/railtie'
require 'jquery-rails'

class LessAssetsJasmineTest < Rails::Application
  routes.append do
    mount Jasminerice::Engine => '/jasmine'
  end

  config.cache_classes = true
  config.active_support.deprecation = :log
  config.assets.enabled = true
  config.assets.version = '1.0'
  config.secret_token = '9696be98e32a5f213730cb7ed6161c79'
end

LessAssetsJasmineTest.initialize!
run LessAssetsJasmineTest
