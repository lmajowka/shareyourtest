class CreateTests < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :title
      t.string :description
      t.references :user
      t.float :price
      t.string :status

      t.timestamps
    end
  end
end
