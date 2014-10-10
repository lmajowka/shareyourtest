class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user, index: true
      t.references :exam, index: true
      t.float :price

      t.timestamps
    end
  end
end
