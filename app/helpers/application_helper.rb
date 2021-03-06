module ApplicationHelper

	def log_event(mine, category, level, description)
		if mine.nil?
	    	@event = Event.new(mine_id: 0,       user_id: current_user.id, user_email: current_user.email, category: category, level: level, description: description)
	    else
	    	@event = Event.new(mine_id: mine.id, user_id: current_user.id, user_email: current_user.email, category: category, level: level, description: description)
	    end
    	@event.save
	end

	def online_users_as_list(users)
		s = ""
		users.each do |user|
			s = s + user.email + "\n"
		end
		return s
	end

	def n(s)
		return "" if s.nil?
		s.to_s
	end

	def is_s_i?(s)
		/\A[-+]?\d+\z/ === s
	end

	def to_url(url)
		return "http://" + url if !url.start_with? "http"
	end

end
