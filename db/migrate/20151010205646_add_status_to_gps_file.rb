class AddStatusToGpsFile < ActiveRecord::Migration
  def change
    add_column :gps_files, :is_in_db, :boolean
  end
end
