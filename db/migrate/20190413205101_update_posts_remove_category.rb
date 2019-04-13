class UpdatePostsRemoveCategory < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:posts, :category, foreign_key: true)
  end
end
