class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @users = User.where('id <> ' + current_user.id.to_s)
    @groups = UserGroup.all
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
    @groups = UserGroup.all
  end

  def new
    @user = User.new
    @groups = UserGroup.all
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

  def update_group
    set_user
    @user.user_group_id = params[:user_group_id]
    @user.save
    log_event(nil, 0, "User", "User " + @user.email + " wurde geändert, neue Gruppe " + @user.user_group.description)
    respond_to do |format|
      format.js {render nothing: true}
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :user_group_id)
    end
end
