class AddHomepageToMines < ActiveRecord::Migration
  def change
    add_column :mines, :homepage, :string
  end
end
