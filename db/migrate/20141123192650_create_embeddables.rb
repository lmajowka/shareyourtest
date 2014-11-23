class CreateEmbeddables < ActiveRecord::Migration
  def change
    create_table :embeddables do |t|
      t.references :exam_category, index: true
      t.text :content
      t.text :title

      t.timestamps
    end
  end
end
