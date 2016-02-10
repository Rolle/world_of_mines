require File.expand_path('../../config/environment', __FILE__)

f = File.new("duplicates.txt","w")
mines = Mine.all
duplicates_check = []
mines.each do |mine|
	duplicates = Mine.where("latitude=? and longitude=? and id <> ?",mine.latitude,mine.longitude, mine.id)	
	duplicates.each do |d|
		if !duplicates_check.include? d.id
			f.puts(mine.id.to_s + " - " + d.id.to_s + ", " + mine.name + " - " + d.name ) 
			duplicates_check << d.id
			duplicates_check << mine.id
		end
	end
end
f.close