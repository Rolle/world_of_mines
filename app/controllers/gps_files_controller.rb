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
    log_event(nil, 1, "File", "Datei "+File.basename(@file.file.path)+" wurde gelöscht.")

    redirect_to gps_files_url, notice: 'Datei gelöscht.'
  end

  def import
    @file = GpsFile.find(params[:id])
    @file.skipped_entries = create_mines_from_file(@file)
    @file.imported = true
    @file.save
    log_event(nil, 1, "File", "Datei "+File.basename(@file.file.path)+" wurde importiert.")
    #redirect_to gps_files_url, notice: 'Datei in DB eingefügt.'
    respond_to do |format|
      format.js {}
    end
  end

  def export
    @mines = Mine.where('gps_file_id ='+params[:id].to_s)
    Mine.transaction do
      @mines.each do |mine|
        mine.destroy
      end
    end
    @file = GpsFile.find(params[:id])
    @file.imported = false
    @file.save
    log_event(nil, 1, "File", "Datei "+File.basename(@file.file.path)+" wurde aus DB entfernt.")
    respond_to do |format|
      format.js {}
    end
  end

  def show
    @file = GpsFile.find(params[:id])
    send_file @file.file.path, filename: File.basename(@file.file.path)
  end

  def new
  	@file = GpsFile.new
  end

  def create
    @file = GpsFile.new(gps_file_params)
    @file.user_id = current_user.id
    @file.count = count_mines_in_file(@file)
    @file.created_at = DateTime.now

    if @file.save
      log_event(nil, 1, "File", "Datei "+File.basename(@file.file.path)+" wurde hochgeladen.")
      redirect_to gps_files_url, notice: 'Datei wurde hochgeladen.'
    else
      render :new
    end
  end

  private

  def gps_file_params
    params.require(:gps_file).permit(:file, :count, :name)
  end
end
