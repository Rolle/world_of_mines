class Mine < ActiveRecord::Base
	#acts_as_indexed fields: [:name, :description, :id]
  belongs_to :gps_file
  has_many :photos
  belongs_to :created_by, class_name: "User", foreign_key: "created_by"
  belongs_to :locked_by, class_name: "User", foreign_key: "locked_by"
  belongs_to :updated_by, class_name: "User", foreign_key: 'updated_by'
end
