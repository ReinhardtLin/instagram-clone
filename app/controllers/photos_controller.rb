class PhotosController < ApplicationController
    before_action :set_photo, :only => [ :show, :edit, :update, :destroy]

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
      # redirect_to :action => :index
      redirect_to photos_url
      flash[:notice] = "photo was successfully created"
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
    @photo.destroy
    redirect_to photos_url
    flash[:alert] = "photo was successfully deleted"
  end

  def tag_path

  end

  private

  def photo_params
    params.require(:photo).permit(:logo, :title, :description, :user_id, :all_tags)
  end

  def set_photo
    @photo = params[:id] ? Photo.find(params[:id]) : Photo.new(photo_params)
  end
end
