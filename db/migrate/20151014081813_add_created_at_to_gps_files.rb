class AddCreatedAtToGpsFiles < ActiveRecord::Migration
  def change
  	add_column :gps_files, :created_at, :datetime
  end
end
