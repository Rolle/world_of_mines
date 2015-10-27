class AddUpdatedByToMines < ActiveRecord::Migration
  def change
    add_column :mines, :updated_by, :integer
  end
end
