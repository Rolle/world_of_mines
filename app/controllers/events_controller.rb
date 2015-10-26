class EventsController < ApplicationController
  before_action :authenticate_user!
	
	def index
		if current_user.is_superadmin?
			@events = Event.all.limit(500).order(created_at: :desc)
		else
			@events = nil
		end
	end

	def clear
		@events = Event.destroy_all
		render action: 'index'
	end

end