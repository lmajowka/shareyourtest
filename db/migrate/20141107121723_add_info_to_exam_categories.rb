class AddInfoToExamCategories < ActiveRecord::Migration
  def change
    add_column :exam_categories, :info, :text
  end


end
