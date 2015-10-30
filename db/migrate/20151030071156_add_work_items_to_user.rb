class AddWorkItemsToUser < ActiveRecord::Migration
  def change
    add_column :users, :work_items, :string
  end
end
