require 'user_room/version'

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
  table_holy_grail_layout
].each { |gem_name| require gem_name }

module UserRoom
  class Engine < Rails::Engine
    config.autoload_paths << "#{ config.root }/app/mailers/concerns/"

    initializer :add_user_room_engine_view_paths do
      ActiveSupport.on_load(:action_controller) do
        views  = "app/views/user_room"
        _root_ = ::UserRoom::Engine.config.root
        prepend_view_path("#{ _root_ }/#{ views }" ) if respond_to?(:prepend_view_path)
      end
    end
  end
end
