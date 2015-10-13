module ApplicationHelper
	def log_event(category, level, description)
	    @event = Event.new(user_id: current_user.id, user_email: current_user.email, category: category, level: level, description: description)
    	@event.save
	end

	def n(s)
		return "" if s.nil?
		s.to_s
	end
end
