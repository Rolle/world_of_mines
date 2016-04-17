class MinesController < ApplicationController
  include ApplicationHelper
  include MinesHelper

  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def fullbackup
    send_data "private/fullbackup_untergrundkataster.kml", filename: "fullbackup_untergrundkataster.kml"
  end

  def kill_all
    @mines = Mine.where(deleted: true)
    @mines.each do |mine|
      mine.destroy
    end
    redirect_to :action => 'paperbin'
  end

  def kill
    @mine = set_mine
    @mine.destroy
    respond_to do |format|
      format.js {}
    end
  end

  def undo
    @mine = set_mine
    @mine.update_attributes(deleted: false)
    respond_to do |format|
      format.js {render "kill"}
    end
  end

  def paperbin
    @mines = Mine.where(deleted: true)
  end

  def clear_work_list
    current_user.clear_work_list()
    respond_to do |format|
      format.js {render "update_work_list"}
    end
  end

  def sort_work_list
    @mines = Mine.find(current_user.work_list_ids)
    @mines.each do |mine|
      mine.sort = params[:sort]
      mine.save
    end
    respond_to do |format|
      format.js {render "update_work_list"}
    end
  end

  def state_work_list
    @mines = Mine.find(current_user.work_list_ids)
    @mines.each do |mine|
      mine.state = params[:state]
      mine.save
    end
    @mines = Mine.find(current_user.work_list_ids)
    respond_to do |format|
      format.js {render "update_work_list"}
    end    
  end

  def export_work_list
    if current_user.admin?
      if params[:ne_lat] and params[:ne_lng] and params[:sw_lat] and params[:sw_lng] 
        @mines = Mine.where("latitude < ? and latitude > ? and longitude < ? and longitude > ? and deleted = ?", params[:ne_lat], params[:sw_lat],params[:ne_lng],params[:sw_lng], false)
        current_user.add_mines_to_workitems(@mines)
        respond_to do |format|
          format.js {render "add_or_remove_list_item"}
        end
      else
        @mines = Mine.where(id: current_user.work_list_ids, deleted: false)
        send_data generate_kml(@mines), filename: "export_untergrundkataster_" + DateTime.now.strftime("%Y%m%d_%H%M%S") + "_" + @mines.count.to_s + ".kml"
      end      
    end
  end

  def export_all
    #@mines = Mine.all
    @mines = Mine.where(deleted: false)
    send_data generate_kml(@mines), filename: "full_export_untergrundkataster_" + DateTime.now.strftime("%Y%m%d_%H%M%S") + "_" + @mines.count.to_s + ".kml"
  end

  def delete_work_list
    @mines = Mine.find(current_user.work_list_ids)
    @mines.each do |mine|
      #mine.destroy      
      mine.update_attributes(deleted: true)
    end
    current_user.clear_work_list()
    @mines = nil
    respond_to do |format|
      format.js {render "update_work_list"}
    end   
  end

  def add_current_list_items    
    current_user.add_workitems(current_user.current_ids)
    respond_to do |format|
      format.js {render "add_or_remove_list_item"}
    end
  end

  def add_page_list_items    
    current_user.add_workitems(current_user.page_ids)
    respond_to do |format|
      format.js {render "add_or_remove_list_item"}
    end
  end

  def add_or_remove_list_item
    current_user.add_or_remove_workitem(params[:id])
    respond_to do |format|
      format.js {}
    end
  end

  def work_list
    @mines = Mine.where(id: current_user.work_list_ids, deleted: false)
  end

  def index
    @mines = Mine.where(deleted: false).page(params[:page])
    current_user.update_page_ids(@mines)
    current_user.update_current_ids(nil)
    @new_mine = Mine.new
    @new_photo = Photo.new
  end

  def search_map
    search_term = params[:search].strip

    search = "(name like '%" + search_term +"%' or description like '%" +search_term +"%' or homepage like '%" + search_term + "%')"
    search = search + " and state = " + params[:state] if (params[:state] != "99")
    search = search + " and sort = " + params[:sort]  if (params[:sort] != "99")
    search = search + " and deleted = 'f'"

    if is_s_i?(search_term)
      search = search + " or id = "+search_term
    end
    @mines = Mine.where(search)

    current_user.update_current_ids(@mines)
    @mines = @mines.page(params[:page])

    current_user.update_page_ids(@mines)
    @new_mine = Mine.new
    @new_photo = Photo.new

    render :map
  end

  def search
    search_term = params[:search].strip

    search = "(name like '%" + search_term +"%' or description like '%" +search_term +"%' or homepage like '%" + search_term + "%')"
    search = search + " and state = " + params[:state] if (params[:state] != "99")
    search = search + " and sort = " + params[:sort]  if (params[:sort] != "99")
    search = search + " and deleted = 'f'"

    if is_s_i?(search_term)
      search = search + " or id = "+search_term
    end
    @mines = Mine.where(search)

    current_user.update_current_ids(@mines)
    @mines = @mines.page(params[:page])

    current_user.update_page_ids(@mines)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :index
  end

  def map
    #@mines = Mine.all.order(latitude: :desc)
    @mines = Mine.where(deleted: false).order(latitude: :desc)
    @new_mine = Mine.new
    @new_photo = Photo.new
  end


  def map_work_list
    @mines = Mine.find(current_user.work_list_ids)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :map
  end

  def created
    @mines = Mine.where(created_by: current_user.id, deleted: false).order(latitude: :desc)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :map
  end

  def last_edited
    @mines = Mine.where(updated_by: current_user.id, deleted: false).limit(20).order(latitude: :desc)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :map
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
    #@mines = Mine.all.order(latitude: :desc)
    @mines = Mine.where(deleted: false).order(latitude: :desc)
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :map
  end

  def updateajax
    @mine = Mine.find(params[:id])
    log_event(@mine, 1, "Mine", "Vorher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at) + ", " + n(@mine.homepage)
    )
    @mine.update_attributes({updated_by: current_user, name: params[:name], 
      description: params[:description], 
      latitude: params[:latitude].to_d.truncate(6).to_f, 
      longitude: params[:longitude].to_d.truncate(6).to_f, 
      state: params[:state], sort: params[:sort], visited_at: params[:visited_at], homepage: params[:homepage]})   
    log_event(@mine, 1, "Mine", "Nachher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at) + ", " + n(@mine.homepage)
    )
    respond_to do |format|
      format.js {}
    end
  end

  def own
    @mines = Mine.where(locked_by: current_user.id.to_s, deleted: false).page(params[:page])
    @new_mine = Mine.new
    @new_photo = Photo.new
    render :index
  end

  def locked
    @mines = Mine.where("locked_by is not null and deleted = 'f'").page(params[:page])
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
      @mine = Mine.new(deleted: false, created_by: current_user,latitude: params[:latitude], longitude: params[:longitude], name: params[:name], description: params[:description], sort: params[:sort], state: params[:state], homepage: params[:homepage])
    else
      @mine = Mine.new(mine_params)
      @mine.created_by = current_user.id
    end
    @mine.latitude = @mine.latitude.to_d.truncate(6).to_f
    @mine.longitude = @mine.longitude.to_d.truncate(6).to_f
    if @mine.save
      log_event(@mine, 1, "Mine", "Neuanlage von:" + 
        n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at) + ", " + n(@mine.homepage)
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
    log_event(@mine, 1, "Mine", "Vorher:" + 
      n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at) + ", " + n(@mine.homepage)
    )
    if @mine.update(mine_params)
      log_event(@mine, 1, "Mine", "Nachher:" + 
        n(@mine.name) + ", " + n(@mine.description)+", " + n(@mine.latitude) + ", " + n(@mine.longitude) + ", " + n(@mine.state.to_s) + ", " + n(@mine.sort.to_s) + ", " + n(@mine.visited_at) + ", " + n(@mine.homepage)
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
    #@mine.destroy
    @mine.update_attributes(deleted: true)
    respond_to do |format|
      format.js {}
    end
  end

  private
    def set_mine
      @mine = Mine.find(params[:id])
    end

    def mine_params
      params.require(:mine).permit(:homepage, :latitude, :longitude, :name, :description, :sort, :state, :locked_by, :created_by, :updated_by)
    end
end
