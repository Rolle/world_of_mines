class AddStateAndVisitedAtToMines < ActiveRecord::Migration
  def change
  	add_column :mines, :state, :nteger
  	add_column :mines, :visited_at, :date
  end
end
