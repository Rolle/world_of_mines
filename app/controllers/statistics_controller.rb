class StatisticsController < ApplicationController
  before_action :authenticate_user!
  
	include MinesHelper

  def index
  	count = Mine.group(:sort).count
  	@sort_count = {}
  	count.keys.each do |key|
  		@sort_count[sort_of_text(key)] = count[key]
  	end

  	count = Mine.group(:state).count
  	@state_count = {}
  	count.keys.each do |key|
  		@state_count[state_to_desc(key)] = count[key]
  	end
	
	  count = User.group(:user_group).count
  	@user_count = {}
  	count.keys.each do |key|
  		@user_count[UserGroup.find(key).description] = count[key]
  	end
    @mines_count = Mine.all.count
    @photos_count = Photo.all.count
    @users_count = User.all.count
    @activity_count_update = {}
    @photos_new_count = {}
    @mines_new_count = {}

    from = DateTime.now - 14.days #because not using current date
    1.upto(14) do |i|
      temp_from = "'" + (from+i.days).strftime("%Y-%m-%d 00:00:00") + "'"
      temp_to =   "'" + (from+i+1.days).strftime("%Y-%m-%d 00:00:00") + "'"
      count = Mine.where("updated_at > " + temp_from + " and updated_at < " + temp_to).count
      @activity_count_update[temp_from.remove(" 00:00:00").remove("'")] = count

      count = Photo.where("created_at > " + temp_from + " and created_at < " + temp_to).count
      @photos_new_count[temp_from.remove(" 00:00:00").remove("'")] = count

      count = Mine.where("created_at > " + temp_from + " and created_at < " + temp_to).count
      @mines_new_count[temp_from.remove(" 00:00:00").remove("'")] = count

    end
  end
end
