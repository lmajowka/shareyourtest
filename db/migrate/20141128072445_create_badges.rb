class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.references :user, index: true
      t.references :exam, index: true
      t.string :badge
      t.timestamps
    end
  end
end
