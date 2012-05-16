# coding: UTF-8

module LessAssets

  # Hook the less template into a Rails app.
  #
  class Engine < Rails::Engine

    config.less_assets = ActiveSupport::OrderedOptions.new

    # Initialize Haml Coffee Assets after Sprockets
    #
    initializer 'sprockets.lessassets', :group => :all, :after => 'sprockets.environment' do |app|
      next unless app.assets

      # Register tilt template
      app.assets.register_engine '.lesst', LessTemplate
    end

  end
end
