module SessionsHelper

  def current_user
    @current_user ||= (User.find(session[:current_user]) rescue nil)
  end

  def current_user=(user)
    session[:current_user] = user.id
  end

  def authenticated?
    !current_user.blank?
  end

  def unauthenticate
  end

end
