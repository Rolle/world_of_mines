class MinesController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def search
    @mines = Mine.where("name like '%" + params[:search] +"%' or description like '%" + params[:search] +"%'")    
    respond_to do |format|
      format.js {}
    end  
  end

  def map
    @mines = Mine.all
  end
  
  def updateajax
    @mine = Mine.find(params[:id])
    log_event(1, "Mine", "Änderungen vorher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
    )
    @mine.update_attributes({name: params[:name], description: params[:description], latitude: params[:latitude], longitude: params[:longitude], state: params[:state], sort: params[:sort], visited_at: params[:visited_at]})   
    log_event(1, "Mine", "Änderungen nachher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
    )
    respond_to do |format|
      format.js {}
    end
  end

  def index
    @mines = Mine.all
  end

  def new
    @mine = Mine.new
  end

  def edit
    @mine = set_mine    
    @photo = Photo.new
  end

  def create
    @mine = Mine.new(mine_params)

    if @mine.save
      log_event(1, "Mine", "Neuanlage von:" + 
        n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
      )
      redirect_to @mine, notice: 'Erfolgreich angelegt.'
    else
      render :new
    end
  end

  def update
    log_event(1, "Mine", "Änderung vorher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)     
    )
    if @mine.update(mine_params)
      log_event(1, "Mine", "Änderung nachher:" + 
        n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
      )
      redirect_to @mine, notice: 'Erfolgreich geändert.'
    else
      render :edit
    end
  end

  def destroy
    log_event(1, "Mine", "Löschung von:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
    )
    @mine.destroy
    redirect_to mines_url, notice: 'Gelöscht!.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mine
      @mine = Mine.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mine_params
      params.require(:mine).permit(:latitude, :longitude, :name, :description, :sort, :state)
    end
end
