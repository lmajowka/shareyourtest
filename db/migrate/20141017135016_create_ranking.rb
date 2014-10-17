class CreateRanking < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :user, index: true
      t.references :exam, index: true
      t.float :performance
    end
  end
end
