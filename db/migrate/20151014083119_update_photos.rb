class UpdatePhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :name, :string
  	add_column :photos, :file, :string
  end
end
