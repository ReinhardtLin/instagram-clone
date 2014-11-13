class PhotoLikesController < ApplicationController
  before_action :find_photo

  def create
    existed_like = @photo.find_by_like(current_user)
    unless existed_like
      @like = @photo.likes.build( params[:id] )
      @like.user = current_user
      @like.save!
    end
    redirect_to :back
  end

  def destroy
    @like = @photo.likes.find( params[:id] )
    if @like.can_delete_by?(current_user)
      @like.destroy
    end

    redirect_to :back
  end

  private

  def find_photo
    @photo = Photo.find( params[:photo_id] )
  end

end
