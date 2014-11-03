class AddPermalinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permalink, :string, uniqueness: true, index: true
  end
end
