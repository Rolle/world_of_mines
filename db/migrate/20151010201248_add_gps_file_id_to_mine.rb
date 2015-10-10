class AddGpsFileIdToMine < ActiveRecord::Migration
  def change
    add_column :mines, :gps_file_id, :integer
  end
end
