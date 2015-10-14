class Mine < ActiveRecord::Base
  belongs_to :gps_file
  has_many :photos
end
