class MinesController < ApplicationController
  before_action :set_mine, only: [:show, :edit, :update, :destroy]

  def map
    @mines = Mine.all
  end

  def index
    @mines = Mine.all
  end

  def show
  end

  def new
    @mine = Mine.new
  end

  def edit
  end

  def create
    @mine = Mine.new(mine_params)

    if @mine.save
      redirect_to @mine, notice: 'Mine was successfully created.'
    else
      render :new
    end
  end

  def update
    if @mine.update(mine_params)
      redirect_to @mine, notice: 'Mine was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @mine.destroy
    redirect_to mines_url, notice: 'Mine was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mine
      @mine = Mine.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mine_params
      params.require(:mine).permit(:latitude, :longitude, :name, :description)
    end
end
