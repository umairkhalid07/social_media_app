class TurboFailureApp < Devise::FailureApp
  def respond
    if request_format == :turbo_stream
      redirect
    else
      super
    end
  end

  def skip_format?
    %w(html turbo_stream */*).include? request_format.to_s
  end
end

Devise.setup do |config|

  config.parent_controller = 'TurboDeviseUserController'
  config.navigational_formats = ['*/*', :html, :turbo_stream]
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  end

  # ==> Controller configuration

  config.scoped_views = true

  # ==> Mailer Configuration

  config.mailer_sender = 'brainxmedia@brainxtech.com'

  # ==> ORM configuration

  require 'devise/orm/active_record'

  # ==> Configuration for any authentication mechanism

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]

  # ==> Configuration for :database_authenticatable

  config.stretches = Rails.env.test? ? 1 : 12

  # ==> Configuration for :confirmable

  config.reconfirmable = true

  # ==> Configuration for :rememberable

  config.expire_all_remember_me_on_sign_out = true

  # ==> Configuration for :validatable

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Configuration for :timeoutable

  # ==> Configuration for :lockable

  # ==> Configuration for :recoverable

  config.reset_password_within = 6.hours

  # ==> Configuration for :encryptable

  # ==> Scopes configuration

  # ==> Navigation configuration

  config.sign_out_via = :delete

  # ==> OmniAuth

  # ==> Warden configuration
  #
  # end

  # ==> Mountable engine configurations

  # ==> Turbolinks configuration
  #
  # end

  # ==> Configuration for :registerable
  #
end
