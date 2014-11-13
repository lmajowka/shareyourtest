class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :exam, index: true
      t.references :user, index: true
      t.text :content

      t.timestamps
    end
  end
end
