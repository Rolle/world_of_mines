class GpsFilesController < ApplicationController
  include GpsFilesHelper

  def index
  	@files = GpsFile.all
  end

  def destroy
    @file = GpsFile.find(params[:id])
    @file.destroy
    redirect_to gps_files_url, notice: 'Datei gelöscht.'
  end

  def import
    @file = GpsFile.find(params[:id])
    create_mines_from_file(@file)
    @file.is_in_db = true
    @file.save
    redirect_to gps_files_url, notice: 'Datei in Datenbank importiert.'
  end

  def export
    @mines = Mine.where('gps_file_id ='+params[:id].to_s)
    @mines.each do |mine|
      mine.destroy
    end
    @file = GpsFile.find(params[:id])
    @file.is_in_db = false
    @file.save
    
    redirect_to gps_files_url, notice: 'Datei aus Datenbank entfernt.'
  end

  def show
    @file = GpsFile.find(params[:id])
  end

  def new
  	@file = GpsFile.new
  end

  def create
    @file = GpsFile.new(gps_file_params)
    @file.user_id = current_user.id

    if @file.save
      redirect_to gps_files_url, notice: 'Datei wurde hochgeladen.'
    else
      render :new
    end
  end

  private

  def gps_file_params
    params.require(:gps_file).permit(:file)
  end
end
