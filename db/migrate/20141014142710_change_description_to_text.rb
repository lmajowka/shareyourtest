class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    change_column :exams, :description, :text
  end
  def down
    change_column :exams, :description, :string
  end
end
