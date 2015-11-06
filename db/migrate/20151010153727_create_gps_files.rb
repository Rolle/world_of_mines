class CreateGpsFiles < ActiveRecord::Migration
  def change
    create_table :gps_files do |t|
      t.string :file_id
      t.integer :user_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
