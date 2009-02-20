class SessionsController < ApplicationController

  def index
    redirect_to_dashboard if authenticated?
  end

  def create
    user = User.find_by_identifier(params[:identifier]) || User.create(:identifier => params[:identifier])
    self.current_user = user
    redirect_to_dashboard
  end

  def destroy
    session.delete
    redirect_to_dashboard
  end

end
