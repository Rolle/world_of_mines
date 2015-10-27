module GpsFilesHelper

	def create_mines_from_file(file)
		doc = Nokogiri::XML(file.file.read)
		placemarks = doc.css("Placemark")

		Mine.transaction do 
			placemarks.each do |placemark|
				name = placemark.css("name").text

				coords = placemark.css("Point").css("coordinates").text.split(",")
				longitude = coords[0]
				latitude= coords[1]			
				m = Mine.new(created_by: current_user.id, name: name.parameterize(), latitude: latitude, longitude: longitude, gps_file_id: file.id)
				m.save
			end
		end
	end

	def count_mines_in_file(file)
		doc = Nokogiri::XML(file.file.read)
		return doc.css("Placemark").size
	end
end
