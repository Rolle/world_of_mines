class AddCreatedByToMines < ActiveRecord::Migration
  def change
    add_column :mines, :created_by, :integer
  end
end
