class Mine < ActiveRecord::Base
  belongs_to :gps_file
  has_many :photos
  belongs_to :user, foreign_key: "locked_by"
end
