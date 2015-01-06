class AddCountryToExamCategories < ActiveRecord::Migration
  def change
    add_column :exam_categories, :country, :text, default: 'us'
  end
end
