class RebuildGpsFileTable < ActiveRecord::Migration
  def change
  	drop_table :gps_files
  end
end
