class AddSkippedEntriesToMines < ActiveRecord::Migration
  def change
    add_column :mines, :skipped_entries, :float
  end
end
