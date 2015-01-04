class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.float :amount
      t.integer :item_number

      t.timestamps
    end
  end
end
