module GpsFilesHelper

	def create_mines_from_file(file)
		doc = Nokogiri::XML(file.file.read)
		placemarks = doc.css("Placemark")
		skipped_entries = 0

		Mine.transaction do 
			placemarks.each do |placemark|
				name = placemark.css("name").text

				coords = placemark.css("Point").css("coordinates").text.split(",")
				longitude = coords[0].to_d.truncate(6).to_f
				latitude= coords[1].to_d.truncate(6).to_f
				mines = Mine.find_by_latitude_and_longitude(latitude, longitude)
				if (mines.nil?)	
					m = Mine.new(created_by: current_user, name: name.parameterize(), sort: 0, state: 0, latitude: latitude, longitude: longitude, gps_file_id: file.id, deleted: false)
					m.save
				else
					skipped_entries = skipped_entries + 1
				end
			end
		end
		return skipped_entries
	end

	def count_mines_in_file(file)
		doc = Nokogiri::XML(file.file.read)
		return doc.css("Placemark").size
	end
end
