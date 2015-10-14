class GpsFile < ActiveRecord::Base
	mount_uploader :file, GpsFileUploader
	belongs_to :user
	has_many :mines
end
