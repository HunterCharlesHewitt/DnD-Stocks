class WelcomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def create_session
    user = User.find_by(name: params[:name])
    if user
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
    
    redirect_to "/scan/"
  end
  
end
