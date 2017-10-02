class AddRememberTokenToUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.timestamps
    end

    add_column :users, :remember_token, :string
    add_index :users, :remember_token
  end
end
