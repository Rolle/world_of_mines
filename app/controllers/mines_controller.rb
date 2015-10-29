class MinesController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def search
    search_term = params[:search].strip
    search = "name like '%" + search_term +"%' or description like '%" +search_term +"%'"
    if is_s_i?(search_term)
      search = search + " or id = "+search_term
    end
    @mines = Mine.where(search).page(params[:page])

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
    if @mine.locked_by == current_user
      @mine.locked_by = nil
    else
      @mine.locked_by = current_user
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
    @mine.update_attributes({updated_by: current_user, name: params[:name], description: params[:description], latitude: params[:latitude], longitude: params[:longitude], state: params[:state], sort: params[:sort], visited_at: params[:visited_at]})   
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
      @mine = Mine.new(created_by: current_user.id,latitude: params[:latitude], longitude: params[:longitude], name: params[:name], description: params[:description], sort: params[:sort], state: params[:state])
    else
      @mine = Mine.new(mine_params)
      @mine.created_by = current_user.id
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
    @mine.photos.each do |photo|
      photo.destroy
    end
    log_event(@mine, 1, "Mine", "Löschung von:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at)
    )
    @mine.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private
    def set_mine
      @mine = Mine.find(params[:id])
    end

    def mine_params
      params.require(:mine).permit(:latitude, :longitude, :name, :description, :sort, :state, :locked_by, :created_by, :updated_by)
    end
end
