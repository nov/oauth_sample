# Hacks
# Support params in get_access_token request for smart.fm API's api_key
class OAuth::RequestToken
  def get_access_token_with_args(options = {}, *args)
    access_token_url = consumer.access_token_url? ? consumer.access_token_url : consumer.access_token_path
    response = consumer.token_request(consumer.http_method, access_token_url, self, options, *args)
    OAuth::AccessToken.new(consumer, response[:oauth_token], response[:oauth_token_secret])
  end
  alias_method :get_access_token_without_args, :get_access_token
  alias_method :get_access_token, :get_access_token_with_args
end