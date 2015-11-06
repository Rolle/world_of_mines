class AddPhotosCountToMines < ActiveRecord::Migration
  def change
    add_column :mines, :photos_count, :integer
  end
end
