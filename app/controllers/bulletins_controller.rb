class BulletinsController < ApplicationController
  def index
    @bulletins_unread = current_user.bulletins.unread_by(current_user).order("created_at DESC")
    @bulletins = current_user.bulletins.order("created_at DESC")
  end

  def mark_bulletin_as_read
    Bulletin.mark_as_read! :all, :for => current_user
  end
end