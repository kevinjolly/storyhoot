class SessionsController < ApplicationController

  skip_before_filter :require_login, except: [:destroy]

  layout 'splash'

  def new
    if logged_in?
      redirect_to feed_path
    end
  end

  def create
    if @user = login(params[:username_or_email], params[:password], params[:remember])
      remember_me!
      if @user.authors.count < 5
        redirect_to find_authors_path
      else
        redirect_to feed_path
      end
      flash[:notice] = "You've signed in successfully"
    else
      redirect_to login_path
      flash[:notice] = 'Username or password is invalid'
    end
  end

  def destroy
    logout
  	redirect_to login_path
  	flash[:notice] = "You've logged out successfully"
  end
end
