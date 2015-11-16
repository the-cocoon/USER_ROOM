# include ::UserRoom::MailerSettingsConcern
module UserRoom
  module MailerSettingsConcern
    extend ActiveSupport::Concern

    included do
      def self.smtp?
        Settings.mailer.service == 'smtp'
      end

      # SomeMailer.test_mail.delivery_method.settings
      if smtp?
        default bcc: 'admin@open-cook.ru'
        default template_path: 'devise/mailer'
        default from: Settings.mailer.smtp.default.user_name

        def self.smtp_settings
          Settings.mailer.smtp.default.to_h
        end
      end
    end

    private

    def env_prefix
      'DEV => ' if Rails.env.development?
    end

    def smtp?
      Settings.mailer.service == 'smtp'
    end

    def default_from
      Settings.mailer.smtp.default.user_name if smtp?
    end
  end
end