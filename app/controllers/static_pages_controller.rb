class StaticPagesController < ApplicationController
  skip_before_filter :require_login

  layout 'plain', :only => [:about, :contact]

  def home
    if current_user
      redirect_to feed_path
    else
      render :layout => 'splash'
    end
  end

  def about
  end

  def contact
  end
  
end
