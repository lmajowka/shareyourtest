class AddPositionToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :position, :integer
  end
end
