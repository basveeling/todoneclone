class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end
  
  def create
    if user = User.authenticate(params[:name],params[:password])
      session[:user_id] = user.id
      redirect_to todos_url
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to page_home_url, :notice => "You have succesfully logged out"
  end
  
end
