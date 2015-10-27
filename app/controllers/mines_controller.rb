class MinesController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def search
    @mines = Mine.where("name like '%" + params[:search] +"%' or description like '%" + params[:search] +"%' or id = " + params[:search]).page(params[:page]).per(100)
    respond_to do |format|
      format.js {}
    end  
  end

  def map
    @mines = Mine.all.order(latitude: :desc)
    @new_mine = Mine.new
    @new_photo = Photo.new
  end
  
  def lock
    @mine = Mine.find(params[:id])
    if @mine.locked_by == current_user.id
      @mine.locked_by = nil
    else
      @mine.locked_by = current_user.id
    end
    @mine.save
    respond_to do |format|
      format.js { }
    end
  end

  def show
    @mine = set_mine
    @mines = Mine.all.order(latitude: :desc)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :map
  end

  def updateajax
    @mine = Mine.find(params[:id])
    log_event(@mine, 1, "Mine", "Änderungen vorher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
    )
    @mine.update_attributes({name: params[:name], description: params[:description], latitude: params[:latitude], longitude: params[:longitude], state: params[:state], sort: params[:sort], visited_at: params[:visited_at]})   
    log_event(@mine, 1, "Mine", "Änderungen nachher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
    )
    respond_to do |format|
      format.js {}
    end
  end

  def index
    @mines = Mine.page(params[:page]).per(100)
    @new_mine = Mine.new
    @new_photo = Photo.new
  end

  def own
    @mines = Mine.where("locked_by = "+current_user.id.to_s).page(params[:page]).per(100)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :index
  end

  def locked
    @mines = Mine.where("locked_by is not null").page(params[:page]).per(100)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :index
  end

  def new
    @mine = Mine.new
  end

  def edit
    @mine = set_mine    
    @photo = Photo.new
  end

  def create
    if (request.format == 'js')
      @mine = Mine.new(latitude: params[:latitude], longitude: params[:longitude], name: params[:name], description: params[:description], sort: params[:sort], state: params[:state])
    else
      @mine = Mine.new(mine_params)
    end

    if @mine.save
      log_event(@mine, 1, "Mine", "Neuanlage von:" + 
        n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
      )
      respond_to do |format|
        format.js {}
        format.html {redirect_to @mine, notice: 'Erfolgreich angelegt.'}
      end
    else
      render :new
    end
  end

  def update
    log_event(@mine, 1, "Mine", "Änderung vorher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)     
    )
    if @mine.update(mine_params)
      log_event(@mine, 1, "Mine", "Änderung nachher:" + 
        n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
      )
      redirect_to @mine, notice: 'Erfolgreich geändert.'
    else
      render :edit
    end
  end

  def destroy
    set_mine
    log_event(@mine, 1, "Mine", "Löschung von:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
    )
    @mine.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mine
      @mine = Mine.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mine_params
      params.require(:mine).permit(:latitude, :longitude, :name, :description, :sort, :state, :locked_by)
    end
end
