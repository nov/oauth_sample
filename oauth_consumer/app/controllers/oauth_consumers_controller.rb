class OauthConsumersController < ApplicationController
  before_filter :require_authentication

  def new
    @consumer = OauthConsumer.new
  end

  def create
    @consumer = OauthConsumer.new(params[:consumer])
    if @consumer.save
      redirect_to_dashboard
    else
      render :action => 'new'
    end
  end

end
