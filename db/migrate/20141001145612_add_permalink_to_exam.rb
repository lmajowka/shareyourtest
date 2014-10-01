class AddPermalinkToExam < ActiveRecord::Migration
  def change
  	add_column :exams, :permalink, :string, uniqueness: true, index: true
  end


end
