class OauthAccessTokensController < ApplicationController
  before_filter :require_authentication
  before_filter :require_oauth_consumer

  def new
    if oauth_service_provider
      access_token.destroy if access_token
      redirect_to authorize_url
    end
  end

  def create
    authorized_token = params[:oauth_token] || session[:request_token]
    new_access_token = oauth_consumer.get_access_token(
      authorized_token,
      session[:request_token_secret],
      params[:oauth_verifier]
    )
    store_access_token(new_access_token)
    clear_request_token
    redirect_to_dashboard
  end

  private

  def require_oauth_consumer
    # skip when no oauth_service_provider is detected
    return true unless oauth_service_provider

    unless oauth_consumer
      flash[:notice] = "setup consumer at first"
      redirect_to new_oauth_consumer_path(:service_provider => oauth_service_provider)
      return false
    end
  end

  def authorize_url
    if request_token.callback_confirmed?
      # Serveice Provider is supporting OAuth 1.0a
      request_token.authorize_url
    else
      request_token.authorize_url + "&oauth_callback=#{callback_url}"
    end
  end

  def callback_url
    oauth_callback_url(:service_provider => oauth_service_provider)
  end

  def request_token
    request_token = oauth_consumer.get_request_token(:oauth_callback => callback_url)
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    request_token
  end

  def clear_request_token
    session[:request_token] = nil
    session[:request_token_secret] = nil
  end

  def access_token
    current_user.oauth_access_tokens.find_by_oauth_consumer_id(oauth_consumer)
  end

  def store_access_token(access_token)
    OauthAccessToken.create(
      :user => current_user,
      :oauth_consumer => oauth_consumer,
      :token => access_token.token,
      :secret => access_token.secret
    )
  end

  def oauth_consumer
    OauthConsumer.find_by_service_provider(oauth_service_provider)
  end

  def oauth_service_provider
    params[:service_provider]
  end

end
