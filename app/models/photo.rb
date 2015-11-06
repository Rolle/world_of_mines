class Photo < ActiveRecord::Base	
	mount_uploader :file, PhotoUploader
	belongs_to :user
	belongs_to :mine, counter_cache: true

	self.per_page = 24
end
