class AddExamCategoryToExam < ActiveRecord::Migration
  def change
    add_reference :exams, :exam_category, index: true
  end
end
