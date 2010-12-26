class PageController < ApplicationController
  skip_before_filter :authorize
  def home
    if User.find_by_id(session[:user_id])
      redirect_to todos_url
    end
  end

end
