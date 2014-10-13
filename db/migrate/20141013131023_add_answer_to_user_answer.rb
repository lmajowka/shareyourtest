class AddAnswerToUserAnswer < ActiveRecord::Migration
  def change
    add_column :user_answers, :answer, :integer
  end
end
