class PhotoFollowsController < ApplicationController

  before_action :check_login
  before_action :find_photo

  def create
    existed_follow = @photo.find_by_follow(current_user)

    unless existed_follow
      @follow = @photo.follows.build( params[:id] )
      @follow.user = current_user
      @follow.save!
    end

    redirect_to :back
  end

  def destroy
    @follow = @photo.follows.find( params[:id] )

    if @follow.can_delete_by?(current_user)
      @follow.destroy
    end

    redirect_to :back
  end

  private

  def find_photo
    @photo = Photo.find( params[:photo_id] )
  end
end
