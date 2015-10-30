module MinesHelper

	def generate_kml(mines)
		kml = "<?xml version='1.0' encoding='UTF-8'?>
				<kml xmlns='http://www.opengis.net/kml/2.2'>
				<Document>
					<name>Untergrundkataster "+ DateTime.now.strftime("%Y%m%d_%H%M%S")+"</name>
					<description>Export von " + @mines.count.to_s + " Eintraegen</description>
					<Folder>"

		mines.each do |mine|
			kml = kml + 
			"<Placemark>
				<name>"+mine.name+"</name>
				<description><![CDATA["+n(mine.description)+"]]></description>
				<styleUrl>#icon-503-DB4436</styleUrl>
				<ExtendedData>
				</ExtendedData>
				<Point>
					<coordinates>"+mine.longitude.to_s+","+mine.latitude.to_s+",0.0</coordinates>
				</Point>
			</Placemark>"
		end
		kml = kml + "</Folder></Document></kml>"
	end

	def create_popup(mine)
		html = link_to('Edit', edit_mine_path(mine), class: 'btn btn-primary btn-xs')
		html = html + ' ' + 	link_to('Delete', mine, method: :delete, data: { confirm: 'Are you sure?'},class: 'btn btn-danger btn-xs')
		return '<b>'+mine.name+ '</b><br/> ' + html
	end

	def state_to_desc(state)
		return "unbekannt" if state==0
		return "offen" if state==1
		return "zugefallen" if state == 2
		return "verschlossen" if state == 3
		return "abgerissen" if state == 4
		return "unbekannt"
	end

	def sort(mine)
		return "0" if mine.sort.nil?
		return mine.sort.to_s
	end

	def state(mine)
		return "0" if mine.state.nil?
		return mine.state.to_s
	end

	def sort_of_text(sort)
		return "N/A" if sort == 0		
		return "Stollen" if sort == 1
		return "Stollenmund" if sort == 2
		return "Tagebau" if sort == 3
		return "Halde" if sort == 4
		return "Bunker" if sort == 5
		return "Luftschutzstollen" if sort == 6
		return "Lost place" if sort == 7
		return "Bergwerk" if sort == 8
		return "Höhle" if sort == 9
		return "Tunnel" if sort == 10
		return "U-Verlagerung" if sort == 11
		
		return "N/A"
	end
end