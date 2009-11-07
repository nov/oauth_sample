class ApplicationController < ActionController::Base
  include ApplicationHelper

  def require_authentication
    unless authenticated?
      redirect_to root_url
    end
  end
  alias_method :login_required, :require_authentication

  def redirect_to_dashboard
    redirect_to oauth_url
  end

end
