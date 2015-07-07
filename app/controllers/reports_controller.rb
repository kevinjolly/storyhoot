class ReportsController < ApplicationController
  def new
  end

  def create
  	@book = Book.find(params[:book_reported])
    @reported_book = ReportedBook.new(:book_id => params[:book_reported], :user_id => params[:reported_by], :report_slang => params[:slang], :report_adult => params[:adult], :report_cist => params[:cist])
    @user = User.find(params[:reported_by]);
  	@book.update_attributes(:report_flag => TRUE)
  	if !@user.reported(@book) && @reported_book.save
      redirect_to feed_path
  	  flash[:notice] = "We will look into the matter"
    else
      redirect_to feed_path
      flash[:notice] = "You have already reported the book"
    end
  end

  def destroy
  end
end
