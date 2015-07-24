class UsersController < ApplicationController

	skip_before_filter :require_login, only: [:new, :create, :activate]
	
	layout 'splash', :only => [:new, :create, :complete_facebook_sign_up]

	def index
		@users = User.text_search(params[:query], params[:page])
	end

	def new
		@user = User.new
		if logged_in?
			redirect_to feed_path
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			auto_login @user
			redirect_to find_authors_path
			flash[:notice] = "A confirmation email has been sent to you. Please confirm your email to be able to post gifs."
		else
			render :new
		end
	end

	def show
		@user = User.find_by(username: params[:id])
		@books = @user.books.order('created_at DESC')
	end

	def edit
		@user = User.find_by(username: params[:id])
		if @user != current_user
			redirect_to current_user
			flash[:notice] = "Error in the request"
		end
	end

	def update
		@user = User.find_by(username: params[:id])
		if @user.update(user_params)
			redirect_to @user
			flash[:notice] = "Profile successfully updated"
		else
			render 'edit'
		end
	end

	def change_password
		user = current_user
		if User.authenticate(user.username, params[:current_password]) &&
			params[:new_password] == params[:confirm_password] &&
			params[:new_password].length >= 6
			user.update_attributes(password: params[:new_password])
			flash[:notice] = "Password change successful"
			redirect_to user
		else
			flash[:notice] = "Password change unsuccessful"
			redirect_to edit_user_path user
		end
	end

	def change_username
		user = current_user
		if user.update_attributes(username: params[:username])
			flash[:notice] = "You have logged in successfully from facebook"
			redirect_to find_authors_path
		else
			flash[:notice] = "Seems like the username already exists."
			redirect_to complete_facebook_sign_up_path
		end
	end

	def activate
		if @user = User.load_from_activation_token(params[:id])
		  @user.activate!
		  redirect_to login_path
		  flash[:notice] = 'Your account has been activated successfully. You can post gifs now.'
		else
		  not_authenticated
		end
	end

	def subscribers
		@user = User.find_by(username: params[:id])
		@subscribers = @user.subscribers
	end

	def feed
		Book.from_users_followed_by(self)
	end

	def newsfeed # this is the view
		@user_now = current_user
		@feed_items = @user_now.feed.paginate(:page => params[:page], :per_page => 5)
	  @comment = Comment.new
	  @users_to_follow = User.where.not(id: @user_now.author_ids).order('total_view_count DESC').limit(6)
	end

	def find_authors
		@authors = User.order('total_view_count DESC').limit(12)
	end

	def complete_facebook_sign_up
	end

	def verify_account
		user = current_user
		if !user.verification_request && user.update_attributes(verification_request: 'requested')
			user.send_verification_request
			flash[:notice] = "You have successfully requested an account verification."
			redirect_to current_user
		else
			flash[:notice] = "You have already requested a verification."
			redirect_to current_user
		end
	end

	private
			def user_params
				params.require(:user).permit(:username, :name, :email, :password, :cover, :avatar, :about_me, :authentications_attributes)
			end
end
