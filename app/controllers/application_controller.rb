class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  
  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end
  def restrict_to_development
    head(:bad_request) unless RAILS_ENV == "development"
  end

end
