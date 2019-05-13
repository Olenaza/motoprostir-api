class UpdateEventsAddBaseAndDesc < ActiveRecord::Migration[5.2]
  def change
    change_table :events do |t|
      t.string :base
      t.string :description
    end
  end
end
