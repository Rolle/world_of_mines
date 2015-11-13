class PhotosController < ApplicationController
  before_action :authenticate_user!
  
  include ApplicationHelper

  def index
  	@photos = Photo.page(params[:page])#.per(24)    
  end

  def own
    @photos = Photo.where(user_id: current_user.id).page(params[:page])#.per(24)    
    render :index
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
  	@photo = Photo.new
  end

  def destroy
    @photo = Photo.find(params[:id])
    log_event(@photo.mine, 1, "Mine", "Löschung von Photo: " + @photo.file.path)
    @photo.destroy
    respond_to do |format|
      format.js {}
    end
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.mine_id = params[:mine_id]
    @photo.photo_type = params[:photo_type]
    if @photo.save
      log_event(@photo.mine, 1, "File", "Datei " + File.basename(@photo.file.path) + " wurde hochgeladen zur " + @photo.mine.name)
      respond_to do |format|
        format.js {}
      end  
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:file, :description, :photo_type)
  end
end
