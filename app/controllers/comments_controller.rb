class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    session[:return_to] ||= request.referer
    if @comment.save 
      flash[:notice] = "Comment Saved."
      if current_user != @comment.book.user
        Bulletin.create(user_id: @comment.book.user.id,
                        content: "#{current_user.username.capitalize} commented on your book \' #{@comment.book.title} \'.",
                        url: "/books/#{@comment.book_id}",
                        notifier: current_user.id)
      end
    else
      flash[:notice] = "Comment not saved."
    end
    redirect_to session.delete(:return_to)
  end

  private
  		def comment_params
  			params.require(:comment).permit(:content, :book_id)
  		end
end
