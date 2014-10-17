class AddPerformanceToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :performance, :float
  end

  def down
  	remove_column :purchases, :performance
  end
end
