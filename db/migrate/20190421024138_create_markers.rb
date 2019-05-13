class CreateMarkers < ActiveRecord::Migration[5.2]
  def change
    create_table :markers do |t|
      t.float :lat
      t.float :lng
      t.boolean :draggable, default: false

      t.timestamps

      t.references :event, foreign_key: true
    end
  end
end
