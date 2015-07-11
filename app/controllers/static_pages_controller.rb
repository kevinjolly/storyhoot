class StaticPagesController < ApplicationController
  skip_before_filter :require_login

  layout 'plain', :only => [:about, :contact]

  def home
    if current_user
      redirect_to feed_path
    end
    render :layout => 'splash'
  end

  def about
  end

  def contact
  end
  
end
