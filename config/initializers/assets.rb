# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
if File.exist?(Staytus::Config.theme_root)
  Rails.application.config.assets.paths << File.join(Staytus::Config.theme_root, 'assets', 'images')
  Rails.application.config.assets.paths << File.join(Staytus::Config.theme_root, 'assets', 'javascripts')
  Rails.application.config.assets.paths << File.join(Staytus::Config.theme_root, 'assets', 'stylesheets')
  Rails.application.config.assets.precompile += ["#{Staytus::Config.theme_name}.css", "#{Staytus::Config.theme_name}.js"]
  Rails.application.config.assets.precompile += [/\.jpg\z/, /\.png\z/, /\.gif\z/, /\.svg\z/]
end

Rails.application.config.assets.precompile += %w( admin.js admin.css )
