class CreateExamCategories < ActiveRecord::Migration
  def change
    create_table :exam_categories do |t|

      t.timestamps
    end
  end
end
