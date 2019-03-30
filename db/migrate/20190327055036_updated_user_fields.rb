class UpdatedUserFields < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove :birth_date
      t.string :gender
      t.rename :nick, :username
    end
  end
end
