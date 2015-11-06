class AddMineIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :mine_id, :integer
  end
end
