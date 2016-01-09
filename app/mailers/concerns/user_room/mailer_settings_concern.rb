# include ::UserRoom::MailerSettingsConcern
module UserRoom
  module MailerSettingsConcern
    extend ActiveSupport::Concern

    included do
      def self.smtp?
        Settings.app.mailer.service == 'smtp'
      end

      # SomeMailer.test_mail.delivery_method.settings
      #
      if smtp?
        default template_path: 'devise/mailer'

        default bcc:  Settings.app.mailer.admin_email
        default from: Settings.app.mailer.smtp.default.user_name

        def self.smtp_settings
          Settings.app.mailer.smtp.default.to_h
        end
      end
    end

    private

    def env_prefix
      'DEV => ' if Rails.env.development?
    end

    def smtp?
      Settings.app.mailer.service == 'smtp'
    end

    def default_from
      Settings.app.mailer.smtp.default.user_name if smtp?
    end
  end
end