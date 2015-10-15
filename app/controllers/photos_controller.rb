class PhotosController < ApplicationController
  before_action :authenticate_user!
  
  include ApplicationHelper

  def index
  	@photo = Photo.all
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    log_event(1, "Foto", "Datei "+File.basename(@photo.file.path)+" wurde gelöscht.")

    redirect_to photos_url, notice: 'Datei gelöscht.'
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
  	@photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.mine_id = params[:mine_id]
    
    if @photo.save
      log_event(1, "File", "Datei " + File.basename(@photo.file.path) + " wurde hochgeladen zur " + @photo.mine.name)
      respond_to do |format|
        format.js {}
      end  
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:file)
  end
end
