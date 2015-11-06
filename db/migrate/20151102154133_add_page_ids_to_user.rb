class AddPageIdsToUser < ActiveRecord::Migration
  def change
    add_column :users, :page_ids, :string
  end
end
