class UploadsController < ApplicationController
  def create
    @upload = Upload.new(upload_params)
    @upload.user_id = current_user.id
    @upload.save
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.delete
  end

  private
      def upload_params
        params.require(:upload).permit(:image)
      end
end
