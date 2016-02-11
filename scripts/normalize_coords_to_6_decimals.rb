require File.expand_path('../../config/environment', __FILE__)

mines = Mine.all
mines.each do |mine|
	mine.latitude = mine.latitude.to_d.truncate(6).to_f
	mine.longitude = mine.longitude.to_d.truncate(6).to_f
	#puts "Updating id " + mine.id.to_s
	mine.save!
end