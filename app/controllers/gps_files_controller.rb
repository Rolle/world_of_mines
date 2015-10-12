class GpsFilesController < ApplicationController
  before_action :authenticate_user!
  
  include GpsFilesHelper
  include ApplicationHelper

  def index
  	@files = GpsFile.all
  end

  def destroy
    @file = GpsFile.find(params[:id])
    @file.destroy
    log_event(1, "File", "Datei "+@file.id.to_s+" wurde gelöscht.")

    redirect_to gps_files_url, notice: 'Datei gelöscht.'
  end

  def import
    @file = GpsFile.find(params[:id])
    create_mines_from_file(@file)
    @file.is_in_db = true
    @file.save
    log_event(1, "File", "Datei "+@file.id.to_s+" wurde importiert.")
    redirect_to gps_files_url, notice: 'Datei in DB eingefügt.'
  end

  def export
    @mines = Mine.where('gps_file_id ='+params[:id].to_s)
    @mines.each do |mine|
      mine.destroy
    end
    @file = GpsFile.find(params[:id])
    @file.is_in_db = false
    @file.save
    log_event(1, "File", "Datei "+@file.id.to_s+" wurde aus DB entfernt.")
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
    @file.count = count_mines_in_file(@file)
    
    if @file.save
      log_event(1, "File", "Datei "+@file.id.to_s+" wurde aus DB hochgeladen.")
      redirect_to gps_files_url, notice: 'Datei wurde hochgeladen.'
    else
      render :new
    end
  end

  private

  def gps_file_params
    params.require(:gps_file).permit(:file, :count)
  end
end
