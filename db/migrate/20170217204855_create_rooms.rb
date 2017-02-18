class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :description
      t.string :number
      t.references :apartment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
