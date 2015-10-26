class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @users = User.where('id <> ' + current_user.id.to_s)
  end

  def sign_up
    @user = User.new
  end

  def destroy
    @user.destroy

    log_event(0, "User", "User " + @user.email + " wurde gelöscht.")
    redirect_to users_url, notice: 'User gelöscht.'
  end

  def show
    @user = set_user
  end

  def new
    @user = User.new
  end

  def update
    if @user.update(user_params)
      redirect_to action: 'index', notice: 'Erfolgreich geändert.'
    else
      render :show
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_event(nil, 0, "User", "User " + @user.email + " wurde angelegt.")
      redirect_to action: 'index', notice: 'Erfolgreich angelegt.'
    else
      render :new
    end
  end

  def switch_admin
    set_user
    @user.is_admin = !@user.is_admin
    @user.save
    log_event(nil, 0, "User", "User " + @user.email + " wurde geändert, neuer Admin-Status " + @user.is_admin?.to_s)
    respond_to do |format|
      format.js {flash.now[:notice] = "Status geändert!"}
    end
  end

    def switch_superadmin
    set_user
    @user.is_superadmin = !@user.is_superadmin
    @user.save
    log_event(nil, 0, "User", "User " + @user.email + " wurde geändert, neuer SuperAdmin-Status " + @user.is_superadmin?.to_s)
    respond_to do |format|
      format.js {flash.now[:notice] = "Status geändert!"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :is_admin, :is_superadmin)
    end
end
