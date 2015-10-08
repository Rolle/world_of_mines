#require "nokogiri"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

doc = Nokogiri::XML(File.open(ARGV[0]))
placemarks = doc.css("Placemark")
puts "Importing " + placemarks.size.to_s + " placemarks..."

placemarks.each do |placemark|
	name = placemark.css("name").text

	coords = placemark.css("Point").css("coordinates").text.split(",")
	longitude = coords[0]
	latitude= coords[1]
	
	m = Mine.new(name: name, latitude: latitude, longitude: longitude)
	m.save

end

puts "Import finished!"