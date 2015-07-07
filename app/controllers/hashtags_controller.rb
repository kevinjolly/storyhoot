class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.text_search(params[:query], params[:page])
  end
end
