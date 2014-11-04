class CreateExamCategory < ActiveRecord::Migration
  def change
    create_table :exam_categories do |t|
      t.string :name
      t.string :permalink
    end
  end
end
