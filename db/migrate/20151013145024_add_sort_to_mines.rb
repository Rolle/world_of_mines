class AddSortToMines < ActiveRecord::Migration
  def change
    add_column :mines, :sort, :integer
  end
end
