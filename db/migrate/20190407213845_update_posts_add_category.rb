class UpdatePostsAddCategory < ActiveRecord::Migration[5.2]
  def change
    change_table :posts do |t|
      t.references :category, foreign_key: true
    end
  end
end
