class AddSkippedEntriesToGpsFiles < ActiveRecord::Migration
  def change
    add_column :gps_files, :skipped_entries, :float
  end
end
