class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :user_email
      t.integer :category
      t.string :description

      t.timestamps null: false
    end
  end
end
