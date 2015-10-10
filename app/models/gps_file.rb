class GpsFile < ActiveRecord::Base
	attachment :file
	belongs_to :user
	has_many :mines
end
