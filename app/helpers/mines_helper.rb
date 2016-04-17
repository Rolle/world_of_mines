module MinesHelper

	STATES_ID = {
		0 => "unbekannt",
		1 => "offen", 
		2 => "zugefallen", 
		3 => "verschlossen", 
		4 => "abgerissen", 
		5 => "verfüllt", 
		6 => "verschollen",
		7 => "aktiv" 
	}
	STATES = {
		"unbekannt" =>0, 
		"offen" => 1, 
		"zugefallen" => 2, 
		"verschlossen" => 3, 
		"abgerissen" => 4, 
		"verfüllt" => 5, 
		"verschollen" => 6, 
		"aktiv" =>7 
	}
	SORTS_ID = {
		0 => "N/A", 
		1 => "Stollen", 
		2 => "Stollenmund", 
		3 => "Tagebau", 
		4 => "Halde", 
		5 => "Bunker",
		6 => "Luftschutzstollen",
		7 => "Lost place",
		8 => "Bergwerk", 
		9 => "Höhle", 
		10 => "Tunnel", 
		11 => "U-Verlagerung", 
		12 => "Montanindustrie",
		13 => "Besucherbergwerk"
	}
	SORTS = {
		"N/A" =>0, 
		"Stollen" => 1, 
		"Stollenmund" => 2, 
		"Tagebau" => 3, 
		"Halde" =>4, 
		"Bunker" =>5,
		"Luftschutzstollen" =>6,
		"Lost place" =>7,
		"Bergwerk" => 8, 
		"Höhle" => 9, 
		"Tunnel" => 10, 
		"U-Verlagerung" => 11, 
		"Montanindustrie" => 12,
		"Besucherbergwerk" => 13
	}
	STATES_ALL = {
		"Alle" => 99,
		"unbekannt" =>0, 
		"offen" => 1, 
		"zugefallen" => 2, 
		"verschlossen" => 3, 
		"abgerissen" => 4, 
		"verfüllt" => 5, 
		"verschollen" => 6, 
		"aktiv" =>7 
	}
	SORTS_ALL = {
		"Alle" => 99,
		"N/A" =>0, 
		"Stollen" => 1, 
		"Stollenmund" => 2, 
		"Tagebau" => 3, 
		"Halde" =>4, 
		"Bunker" =>5,
		"Luftschutzstollen" =>6,
		"Lost place" =>7,
		"Bergwerk" => 8, 
		"Höhle" => 9, 
		"Tunnel" => 10, 
		"U-Verlagerung" => 11, 
		"Montanindustrie" => 12,
		"Besucherbergwerk" => 13
	}

	def generate_kml(mines)
		kml = "<?xml version='1.0' encoding='UTF-8'?>
				<kml xmlns='http://www.opengis.net/kml/2.2'>
				<Document>
					<name>Untergrundkataster "+ DateTime.now.strftime("%Y%m%d_%H%M%S")+"</name>
					<description>Export von " + mines.count.to_s + " Eintraegen</description>
					<Folder>"

		mines.each do |mine|
			kml = kml + 
			"<Placemark>
				<name><![CDATA["+mine.name+"]]></name>"
			if (mine.description)
				kml = kml + "<description><![CDATA["+mine.description+"]]></description>"
			end
			kml = kml + 
				"<styleUrl>#icon-503-DB4436</styleUrl>
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
		if STATES_ID.key?(state)
			STATES_ID[state] 
		else 
			return "unbekannt"
		end
	end

	def sort_of_text(sort)
		if SORTS_ID.key?(sort)
			return SORTS_ID[sort] 
		else 
			return "N/A"
		end
	end

	def sort(mine)
		return "0" if mine.sort.nil?
		return mine.sort.to_s
	end

	def state(mine)
		return "0" if mine.state.nil?
		return mine.state.to_s
	end

end