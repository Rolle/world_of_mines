module MinesHelper
	def create_popup(mine)
		html = link_to('Edit', edit_mine_path(mine), class: 'btn btn-primary btn-xs')
		html = html + ' ' + 	link_to('Delete', mine, method: :delete, data: { confirm: 'Are you sure?'},class: 'btn btn-danger btn-xs')
		return '<b>'+mine.name+ '</b><br/> ' + html
	end

	def state_to_desc(state)
		return "unbekannt" if state==0 or state.nil?
		return "offen" if state==1
		return "zugefallen" if state == 2
		return "verschlossen"
	end

	def sort_of_text(sort)
		return "N/A" if sort == 0
		return "Bergwerk" if sort == 8
		return "Stollen" if sort == 1
		return "Stollenmund" if sort == 2
		return "Tagebau" if sort == 3
		return "Halde" if sort == 4
		return "Bunker" if sort == 5
		return "Luftschutzstollen" if sort == 6
		return "Lost place" if sort == 7
		
		return "N/A"
	end
end