class PhotoCommentsController < ApplicationController

  before_action :check_login
  before_action :find_photo

  def create
    @comment = @photo.comments.build( comment_params )
    @comment.user = current_user
    if @comment.save
      redirect_to photo_url( @photo )
    else
      render "/photos/show"
    end
  end

  def destroy
    @comment = @photo.comments.find( params[:id] )

    if @comment.can_delete_by?(current_user)
      @comment.destroy
      redirect_to :back
    end
  end

  private

  def find_photo
    @photo = Photo.find( params[:photo_id] )
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end