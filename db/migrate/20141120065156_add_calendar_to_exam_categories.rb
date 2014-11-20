class AddCalendarToExamCategories < ActiveRecord::Migration
  def change
    add_column :exam_categories, :calendar, :text
  end
end
