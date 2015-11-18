class StatisticsController < ApplicationController
  def index
  	@stollen_count = Mine.where(sort: 1).size
  	@bunker_count = Mine.where(sort: 5).size
  	@besucherbergwerk_count = Mine.where(sort: 13).size
  	@na_count = Mine.where(sort: 0).size
  end
end
