class PhotosController < ApplicationController

  before_action :check_login, :except => [:index]
  before_action :set_photo, :only => [ :show, :edit, :update, :destroy]

  before_action :require_photo_author!, :only => [:edit, :update, :destroy]

  def index
    if params[:tag]
      @photos = Photo.tagged_with(params[:tag])
    else
      @photos = Photo.all
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    if @photo.save
      flash[:notice] = "photo was successfully created"
      redirect_to photos_url
    else
      render :action => :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to photo_url(@photo)
      flash[:notice] = "photo was successfully updated"
    else
      render :action => :edit
    end
  end

  def destroy
    @photo.destroy if @photo.user == current_user

    redirect_to photos_url
    flash[:alert] = "photo was successfully deleted"
  end

  private

  def require_photo_author!
    unless @photo.can_delete_by?(current_user)
      flash[:alert] = "Yo! man! you can't do this!"
      redirect_to root_path
    end
  end

  def photo_params
    params.require(:photo).permit(:logo, :title, :description, :user_id, :all_tags)
  end

  def set_photo
    @photo = params[:id] ? Photo.find(params[:id]) : Photo.new(photo_params)
  end
end
