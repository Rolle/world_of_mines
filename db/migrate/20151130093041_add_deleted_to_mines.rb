class AddDeletedToMines < ActiveRecord::Migration
  def change
    add_column :mines, :deleted, :boolean
    #Mines.update_all(deleted: false)
  end
end
