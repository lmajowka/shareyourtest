class AddCountryToExams < ActiveRecord::Migration
  def change
    add_column :exams, :country, :text, default: 'us'
  end
end
