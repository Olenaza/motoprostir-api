class AddUniqueConstraints < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, :unique => true
    add_index :users, :username, :unique => true
    add_index :categories, :name, :unique => true
    add_index :brands, :name, :unique => true
  end
end
