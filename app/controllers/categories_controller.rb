class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category = Category.find(params[:id])
    @books = category.books.order('created_at DESC')
    @comment = Comment.new
  end
end
