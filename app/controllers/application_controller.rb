class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_last_seen_at, if: proc { user_signed_in? && (session[:last_seen_at] == nil || session[:last_seen_at] < 5.minutes.ago) }
  before_action :load_online_users, if: proc {user_signed_in?}

  private
  	def load_online_users
  		@users_online = User.where("last_seen_at > ? and id <>" + current_user.id.to_s, 5.minutes.ago)
	end

	def set_last_seen_at
  		current_user.update_attribute(:last_seen_at, Time.now)
  		session[:last_seen_at] = Time.now
	end
end
