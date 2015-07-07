class StaticPagesController < ApplicationController
  skip_before_filter :require_login

  layout 'landing'

  def home
    if current_user
      redirect_to feed_path
    end
  end
  
end
