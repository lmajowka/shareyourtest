class AddNumberOfRatingsToExams < ActiveRecord::Migration
  def change
    add_column :exams, :number_of_ratings, :integer
  end
end
