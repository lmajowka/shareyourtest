class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :exam, index: true
      t.text :content
      t.integer :answer

      t.timestamps
    end
  end
end
