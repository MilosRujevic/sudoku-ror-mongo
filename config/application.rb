require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SudokuApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    # @see http://stackoverflow.com/questions/19098663/auto-loading-lib-files-in-rails-4
    config.autoload_paths += %W(#{config.root}/lib)
    # @see http://www.williambharding.com/blog/technology/rails-3-autoload-modules-and-classes-in-production/
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # config.autoload_paths += Dir["#{config.root}/app/models/**/"]

    # Grape REST API Rack application support
    config.paths.add 'app/api', glob: '**/*.rb'
    config.autoload_paths += Dir["#{Rails.root}/app/api/*"]
    config.middleware.use(Rack::Config) do |env|
      env['api.tilt.root'] = Rails.root.join 'app', 'views', 'api'
    end
    config.assets.paths << Rails.root.join('lib', 'assets', 'bower_components', 'bootstrap-sass-official', 'assets', 'stylesheets')
    config.assets.paths << Rails.root.join('lib', 'assets', 'bower_components', 'bootstrap-sass-official', 'assets', 'fonts')
  end
end
