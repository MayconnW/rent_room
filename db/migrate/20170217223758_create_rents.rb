class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.references :room, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.integer :day_payment
      t.integer :status

      t.timestamps null: false
    end
  end
end
