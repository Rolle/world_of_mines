class AddLockedByToMines < ActiveRecord::Migration
  def change
    add_column :mines, :locked_by, :integer
  end
end
