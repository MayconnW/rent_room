# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( main.js )
Rails.application.config.assets.precompile += %w( plugins/jquery-1.11.2.min.js )
Rails.application.config.assets.precompile += %w( plugins/jquery-migrate-1.2.1.min )
Rails.application.config.assets.precompile += %w( plugins/bootstrap/js/bootstrap.min )
Rails.application.config.assets.precompile += %w( plugins/jquery-rss/dist/jquery.rss.min )
Rails.application.config.assets.precompile += %w( plugins/bootstrap/css/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( plugins/font-awesome/css/font-awesome )
Rails.application.config.assets.precompile += %w( styles.css )
Rails.application.config.assets.precompile += %w( rich/editor.css )