class AddNumberOfQuestionToExams < ActiveRecord::Migration
  def change
    add_column :exams, :number_of_questions, :integer
  end
end
