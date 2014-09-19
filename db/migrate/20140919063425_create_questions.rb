class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :test, index: true
      t.text :content
      t.integer :answer

      t.timestamps
    end
  end
end
