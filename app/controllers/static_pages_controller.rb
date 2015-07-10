class StaticPagesController < ApplicationController
  skip_before_filter :require_login

  layout 'splash'

  def home
    if current_user
      redirect_to feed_path
    end
  end

  def about
  end

  def contact
  end
  
end
