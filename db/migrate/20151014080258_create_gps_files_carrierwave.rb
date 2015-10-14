class CreateGpsFilesCarrierwave < ActiveRecord::Migration
  def change
    create_table :gps_files_carrierwaves do |t|
      t.string :name
      t.string :file
      t.integer :user_id
      t.integer :count
      t.boolean :imported
    end
  end
end
