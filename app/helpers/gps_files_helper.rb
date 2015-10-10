module GpsFilesHelper

	def create_mines_from_file(file)
		doc = Nokogiri::XML(file.file.read)
		placemarks = doc.css("Placemark")

		placemarks.each do |placemark|
			name = placemark.css("name").text

			coords = placemark.css("Point").css("coordinates").text.split(",")
			longitude = coords[0]
			latitude= coords[1]
			
			m = Mine.new(name: name, latitude: latitude, longitude: longitude, gps_file_id: file.id)
			m.save

		end
	end
end
