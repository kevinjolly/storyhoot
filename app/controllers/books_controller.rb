class BooksController < ApplicationController

	after_action :update_user_total_view_count, only: :show

	layout 'gif_maker', :only => [:new, :create, :gif_maker_pictures, :gif_maker_video, :gif_upload]

	def index
		if params[:query].present?
			if params[:query][0] == "#"
				redirect_to hashtags_path(query: params[:query])
			end
			if params[:query][0] == "@"
				redirect_to users_path(query: params[:query])
			end
		else
			redirect_to request.referer
		end
		@books = Book.text_search(params[:query], params[:page])
	end

	def new
		@book = Book.new
	end

	def create
		if current_user.activation_state != 'active'
			redirect_to current_user
			flash[:notice] = "You have to confirm your mail to post gifs"
		else
			book = Book.new(book_params);
			book.user_id = current_user.id
			book.save
		end
		respond_to do |format|
			format.html do 
				flash[:notice] = "Your GIF has been successfully saved!"
				redirect_to current_user
			end
			format.js
		end
	end

	def show
		@book = Book.find(params[:id])
		@comment = Comment.new
		impressionist(@book)
	end

	def destroy
		@book = Book.find(params[:id])
		user = User.find(@book.user_id)
		@book.destroy
		respond_to do |format|
			format.html {redirect_to user}
			format.js
		end
	end

	def like
		@book = Book.find(params[:id]);
		@book.liked_by current_user
		if @book.user.id != current_user.id
			Bulletin.create(user_id: @book.user.id,
											content: "#{current_user.username.capitalize} liked your book \' #{@book.title} \'.",
											url: "/books/#{@book.id}",
											notifier: current_user.id)
		end
		respond_to do |format|
			format.html {redirect_to :back}
			format.js
		end
	end

	def unlike
		@book = Book.find(params[:id]);
		@book.unliked_by current_user
		respond_to do |format|
			format.html {redirect_to :back}
			format.js
		end
	end

	def discover
		@books = Book.order('view_count DESC').limit(24)
	end

	def gif_maker_pictures
		@book = Book.new
	end

	def gif_maker_video
		@book = Book.new
	end

	def gif_upload
		@book = Book.new
	end

	private
			def book_params
				params.require(:book).permit(:title, :cover, :category_id)
			end

			def update_user_total_view_count
				@book = Book.find(params[:id])
				@book.user.update_user_total_view_count
			end
end
