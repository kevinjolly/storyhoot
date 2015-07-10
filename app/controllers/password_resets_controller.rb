class PasswordResetsController < ApplicationController

  skip_before_filter :require_login

  layout 'splash'

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    redirect_to root_path
    flash[:notice] = "Email sent with password reset instructions"
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    user = User.find_by(password_reset_token: params[:id])
    if user && params[:new_password] == params[:confirm_password]
      user.update_attributes(password: params[:new_password]) if user
      redirect_to login_path
      flash[:notice] = 'Password has been reset'
    else
      redirect_to login_path
      flash[:notice] = 'Check your form for errors'
    end
  end
end
