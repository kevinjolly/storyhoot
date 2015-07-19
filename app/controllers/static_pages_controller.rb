class StaticPagesController < ApplicationController
  skip_before_filter :require_login

  layout 'plain'

  def home
    if current_user
      redirect_to feed_path
    else
      render :layout => 'splash'
    end
  end

  def about
  end

  def privacy
  end

  def terms
  end
  
end
