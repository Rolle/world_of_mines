class AddIsSuperadminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_superadmin, :boolean
  end
end
