class OauthConsumer < ActiveRecord::Base
  has_many :oauth_access_tokens

  # TODO: RSA-SHA1 support
  # Service providers using only RSA-SHA1 does not use consumer_secret.
  # ref.) http://devlog.agektmr.com/ja/archives/174
  validates_presence_of :service_provider, :consumer_key, :consumer_secret, :message => 'is required'
  validates_presence_of :scope, :if => :scope_is_required?, :message => 'is required'
  validates_uniqueness_of :service_provider, :message => 'is already registered'

  def validate
    errors.add(:service_provider, "is not supported") unless service_provider_is_supported?
  end

  def get_request_token(options = {})
    consumer.get_request_token(options, token_options)
  end

  def get_access_token(token, secret, verifier = "")
    request_token = OAuth::RequestToken.new(consumer, token, secret)
    request_token.get_access_token(:oauth_verifier => verifier)
  end

  def self.service_providers
    @service_providers ||= YAML.load_file("#{RAILS_ROOT}/config/service_providers.yml")
  end

  def service_providers
    self.class.service_providers
  end

  def service_provider_options
    service_providers[self.service_provider]
  end

  private

  def consumer
    OAuth::Consumer.new(consumer_key, consumer_secret, consumer_options)
  end

  def consumer_options
    {
      :site              => service_provider_options['site'],
      :request_token_url => service_provider_options['request_token_url'],
      :authorize_url     => service_provider_options['authorize_url'],
      :access_token_url  => service_provider_options['access_token_url'],
      :realm             => service_provider_options['realm'],
      :scheme            => service_provider_options['scheme'],
      :signature_method  => service_provider_options['signature_method'],
      :http_method       => service_provider_options['http_method']
    }.reject! { |key, value| value.blank? }
  end

  def token_options
    scope.blank? ? {} : {:scope => scope}
  end

  def service_provider_is_supported?
    !service_provider_options.blank?
  end

  def scope_is_required?
    service_provider == 'google'
  end

end
