class ApplicationController < ActionController::Base
  include ApplicationHelper

  def require_authentication
    unless authenticated?
      redirect_to root_url
    end
  end

  def redirect_to_dashboard
    redirect_to dashboard_url
  end

end
