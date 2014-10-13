class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.references :user, index: true
      t.references :purchase, index: true
      t.references :question, index: true
      t.references :answer, index: true
      t.string :status
      t.integer :seconds

      t.timestamps
    end
  end
end
