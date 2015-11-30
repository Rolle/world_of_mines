class AddPhotoTypeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_type, :integer
    Photo.update_all(photo_type: 0)
  end
end
