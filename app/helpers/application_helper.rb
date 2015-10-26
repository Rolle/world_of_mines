module ApplicationHelper
	#def log_event(category, level, description)
	#    @event = Event.new(mine_id: nil, user_id: current_user.id, user_email: current_user.email, category: category, level: level, description: description)
   # 	@event.save
	#end

	def log_event(mine, category, level, description)
		if mine.nil?
	    	@event = Event.new(mine_id: 0,       user_id: current_user.id, user_email: current_user.email, category: category, level: level, description: description)
	    else
	    	@event = Event.new(mine_id: mine.id, user_id: current_user.id, user_email: current_user.email, category: category, level: level, description: description)
	    end
    	@event.save
	end

	def n(s)
		return "" if s.nil?
		s.to_s
	end
end
