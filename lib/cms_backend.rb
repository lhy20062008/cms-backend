module CmsBackend
  Dir[[__dir__, 'cms-backend', '*.rb'].join('/')].sort.each { |f| require f }

  if defined? ::Rails::Railtie
    require 'cms_backend/railtie'
    require 'cms_backend/engine'
  end

  # ActiveSupport.on_load(:action_view) do
  #   include Helper::AuditLog
  #   include Helper::Miscellaneous
  #   include Helper::Cms
  # end

  # ActiveSupport.on_load(:action_controller) do
  #   include Jwt
  # end

  # def self.configure
  #   yield(config)
  # end

  # def self.config
  #   @config ||= Configuration.new
  #   @config.token_expiry_day ||= 30 #days
  #   @config.devise_jwt_secret_key ||= Rails.application.secrets.devise_jwt_secret_key
  #   @config.base_client_timeout ||= 30 # seconds
  #   @config.consumer_job_count ||= 1
  #   @config
  # end

  # def self.generate_license_key
  #   file = File.expand_path("../../private_key.pem", __FILE__)
  #   rsa = OpenSSL::PKey::RSA.new File.read file
  #   payload = {
  #     exp: 100.minutes.from_now.to_i
  #   }
  #   token = JWT.encode payload, rsa, 'RS256'
  #   token
  # end

  # def self.license_key_verfy!
  #   file = File.expand_path("../../public_key.pem", __FILE__)
  #   rsa_pub = OpenSSL::PKey::RSA.new File.read file
  #   license_key = config.license_key
  #   decode_token = JWT.decode license_key, rsa_pub, true, { algorithm: 'RS256' }
  #   decode_token
  # end
end
