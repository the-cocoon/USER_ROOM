require 'user_room/version'
require 'user_room/config'

%w[
  devise
  omniauth-twitter
  omniauth-facebook
  omniauth-vkontakte
  omniauth-google-oauth2
  omniauth-odnoklassniki

  slim
  config

  pagination
  simple_sort
  to_slug_param
  premailer/rails

  mini_magick
  paperclip

  image_tools
  crop_tool

  log_js
  role_slim_js
  notifications

  protozaur
  protozaur_theme
].each { |gem_name| require gem_name }

module UserRoom
  class Engine < Rails::Engine
    config.autoload_paths << "#{ config.root }/app/mailers/concerns/"

    initializer :add_user_room_engine_view_paths do
      ActiveSupport.on_load(:active_record) do
        _root_ = ::UserRoom::Engine.config.root
        ::Rails.application.config.paths['db/migrate'] << "#{ _root_ }/db/migrate"
      end

      ActiveSupport.on_load(:action_controller) do
        views  = "app/views/user_room"
        _root_ = ::UserRoom::Engine.config.root
        prepend_view_path("#{ _root_ }/#{ views }" ) if respond_to?(:prepend_view_path)
      end
    end

    # ::HakushuIo::Application.config.paths['db/migrate'] << "#{ _views_root_ }/db/migrate"
  end
end

_root_ = File.expand_path('../../', __FILE__)
require "#{ _root_ }/config/routes"