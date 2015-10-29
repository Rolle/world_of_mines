class DropColumnsUser < ActiveRecord::Migration
  def change
  	#|is_admin|is_superadmin|
  	remove_column :users, :is_admin
  	remove_column :users, :is_superadmin
  end
end
