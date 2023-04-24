class AddTotalUnbuyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_unbuy, :integer, default: 0
  end
end
