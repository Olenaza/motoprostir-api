class UpdateUsersAddAvatarAndCover < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.text :avatar
      t.text :cover
    end
  end
end
