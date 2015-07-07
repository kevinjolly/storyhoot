class SubscriptionsController < ApplicationController
	def create
		@user = User.find(params[:subscription][:author_id])
		current_user.subscribe!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = Subscription.find(params[:id]).author
		current_user.unsubscribe!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end