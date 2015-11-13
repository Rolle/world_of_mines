class Mine < ActiveRecord::Base
	#acts_as_indexed fields: [:name, :description, :id]
  belongs_to :gps_file
  has_many :photos, dependent: :destroy
  belongs_to :created_by, class_name: "User", foreign_key: "created_by"
  belongs_to :locked_by, class_name: "User", foreign_key: "locked_by"
  belongs_to :updated_by, class_name: "User", foreign_key: 'updated_by'

  def documents
  	documents = []
  	photos.each do |photo|
  		documents << photo if photo.photo_type == 1
  	end
  	return documents
  end

  def images
  	images = []
  	photos.each do |photo|
  		images << photo if photo.photo_type != 1
  	end
  	return images
  end

end
