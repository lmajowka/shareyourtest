class AddDescriptionToExamCategories < ActiveRecord::Migration
  def change
    add_column :exam_categories, :description, :text
  end
end
