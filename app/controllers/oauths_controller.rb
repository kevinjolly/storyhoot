class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      if @user.authors.count < 5
        redirect_to find_authors_path, :notice => "Logged in from #{provider.titleize}!"
      else
        redirect_to feed_path, :notice => "Logged in from #{provider.titleize}!"
      end
    else
      begin
        @user = create_from(provider)
        @user.activate!
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to find_authors_path, :notice => "Logged in from #{provider.titleize}! Please change your username."
      rescue
        redirect_to login_path, :notice => "Failed to login from #{provider.titleize}!"
      end
    end
  end

  private
      def auth_params
        params.permit(:code, :provider)
      end

end