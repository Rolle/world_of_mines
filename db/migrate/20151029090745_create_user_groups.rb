class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.text :description
    end
  end
end
