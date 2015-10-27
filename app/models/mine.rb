class Mine < ActiveRecord::Base
  belongs_to :gps_file
  has_many :photos
  belongs_to :created_by, class_name: "User", foreign_key: "created_by"
  belongs_to :locked_by, class_name: "User", foreign_key: "locked_by"
  belongs_to :updated_by, class_name: "User", foreign_key: 'updated_by'
end
