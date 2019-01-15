class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nick
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :password_digest
      t.date :birth_date
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
