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
end