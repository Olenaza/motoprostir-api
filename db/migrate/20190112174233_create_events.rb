class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :type
      t.string :ride_style
      t.string :speed
      t.date :start_date
      t.date :end_date
      t.string :countries, array:true
      t.string :cities, array:true

      t.timestamps

      t.references :user, foreign_key: true
    end

    add_index :events, :countries, using: 'gin'
    add_index :events, :cities, using: 'gin'
  end
end
