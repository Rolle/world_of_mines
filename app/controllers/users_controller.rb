class UsersController < ApplicationController
  before_action :set_mine, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @users = User.all
  end

  def sign_up
    @user = User.new
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
