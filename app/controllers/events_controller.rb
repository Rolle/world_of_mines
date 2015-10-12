class EventsController < ApplicationController
  before_action :authenticate_user!
	
	def index
		if current_user.is_superadmin?
			@events = Event.all.limit(500)
		else
			@events = nil
		end
	end

end