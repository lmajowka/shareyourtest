class AddCountryToExamCategories < ActiveRecord::Migration
  def change

    add_column :exam_categories, :country, :string, default: 'us'
  end
end
