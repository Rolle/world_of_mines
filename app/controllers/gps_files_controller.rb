class GpsFilesController < ApplicationController
  def index
  	@files = GpsFile.all
  end

  def destroy
  end

  def edit
  end

  def new
  	@file = GpsFile.new
  end
end
