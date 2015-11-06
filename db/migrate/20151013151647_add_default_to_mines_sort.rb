class AddDefaultToMinesSort < ActiveRecord::Migration
	def change
		#remove_column :mines, :sort
	  	#add_column :mines, :sort, :integer, default: 0
	end
end
