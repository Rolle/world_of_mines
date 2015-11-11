class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :first_approval
      t.integer :second_approval

      t.timestamps null: false
    end
  end
end
