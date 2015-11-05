class AddIndexesToTables < ActiveRecord::Migration
  def change
  	add_index :events, :mine_id
  	add_index :events, :user_id

  	add_index :mines, :id
  	add_index :mines, :sort
  	add_index :mines, :state

  	add_index :photos, :id
  	add_index :photos, :mine_id
  	add_index :photos, :user_id

  	add_index :users, :id
  end
end
