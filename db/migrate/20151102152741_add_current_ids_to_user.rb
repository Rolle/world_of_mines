class AddCurrentIdsToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_ids, :string
  end
end
